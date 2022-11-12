/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fdb;

class _FPostgresInstance extends FDBInstance {
  late final _FPostgresConnection conn;
  PostgreSQLExecutionContext? transactionCtx;

  _FPostgresInstance(FPostgresDB fdb) {
    conn = _FPostgresConnection(fdb);
    lifetime = fdb.settings.idleLifetime;
  }

  @override
  Future<FError> execute({required String sql, Map<String, dynamic>? pars}) async {
    final err = FError.notError();

    if (transactionCtx == null && !await conn.open(null, () => err)) {
      return err;
    }

    await asyncTry(
      setError: () => err,
      action: () async {
        if (transactionCtx != null) {
          await transactionCtx?.execute(sql, substitutionValues: _transformPars(pars));
        } else {
          await conn.conn.execute(sql, substitutionValues: _transformPars(pars));
        }
      },
    );

    return err;
  }

  @override
  Future<FDBResponse<FDBRow?>> executeReturn({required String sql, Map<String, dynamic>? pars}) async {
    final res = await select(sql: sql, pars: pars);
    return _FDBResponse(res.err, res.data.isEmpty ? null : res.data.first);
  }

  @override
  Future<FDBResponse<List<FDBRow>>> select({required String sql, Map<String, dynamic>? pars}) async {
    final err = FError.notError();

    if (transactionCtx == null && !await conn.open(null, () => err)) {
      return _FDBResponse(err, []);
    }

    final rows = await asyncTry(
      setError: () => err,
      action: () async {
        List<Map<String, Map<String, dynamic>>> rows = [];
        if (transactionCtx != null) {
          rows = await transactionCtx!.mappedResultsQuery(sql, substitutionValues: _transformPars(pars));
        } else {
          rows = await conn.conn.mappedResultsQuery(sql, substitutionValues: _transformPars(pars));
        }

        final result = <FDBRow>[];
        for (final row in rows) {
          final dict = <String, dynamic>{};
          for (final v in row.values) {
            dict.addAll(v);
          }

          result.add(_FDBRow(dict));
        }

        return result;
      },
    );

    return _FDBResponse(err, rows ?? []);
  }

  @override
  Future<FDBResponse<T?>> transaction<T>(Future<T?> Function(FDBTransaction trx) callback) async {
    final err = FError.notError();

    if (!await conn.open(null, () => err)) {
      return _FDBResponse(err, null);
    }

    final res = await conn.conn.transaction((ctx) async {
      transactionCtx = ctx;
      final transaction = _FPostgresTransaction(() => this);

      final res = await asyncTry<T>(
        setError: () {
          try {
            ctx.cancelTransaction(reason: 'uncaught exception error');
          } catch (_) {}

          return err;
        },
        action: () async {
          return await callback(transaction);
        },
      );

      transactionCtx = null;
      return res;
    });

    return _FDBResponse(err, res);
  }

  @override
  void dispose() {
    super.dispose();
    conn.close();
  }
}

class _FPostgresConnection {
  final FPostgresDB _fdb;

  PostgreSQLConnection? _conn;
  PostgreSQLConnection get conn {
    _conn ??= PostgreSQLConnection(
      _fdb.host,
      _fdb.port,
      _fdb.name,
      username: _fdb.user,
      password: _fdb.password,
    );
    return _conn!;
  }

  _FPostgresConnection(this._fdb);

  Future<void> close() async {
    if (_conn != null) {
      await _conn!.close();
    }
  }

  Future<bool> open(FOnError? onError, FSetError? setError) async {
    var isConnected = _conn != null;

    if (isConnected) {
      await asyncTry(
        action: () => conn.query('SELECT 1'),
        onError: (err, stackTrace) async {
          await asyncTry(action: () => conn.close());
          _conn = null;
          isConnected = false;
        },
      );
    }

    if (!isConnected) {
      await asyncTry(
        action: () async {
          await conn.open();
          isConnected = true;
        },
        onError: (err, stackTrace) async {
          await onError?.call(err, stackTrace);
          if (setError != null) {
            final err = setError();
            err.isError = true;
            err.err = err;
            err.stackTrace = stackTrace;
          }
        },
      );
    }

    return isConnected;
  }
}
