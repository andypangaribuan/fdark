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

  _FPostgresInstance(FPostgresDB fdb) {
    conn = _FPostgresConnection(fdb);
    lifetime = fdb.settings.idleLifetime;
  }

  @override
  Future<List<FDBRow>> query(String sql, {FOnError? onError, FSetError? setError, Map<String, dynamic>? pars}) async {
    if (!await conn.open(onError, setError)) {
      return [];
    }

    final result = await asyncTry(
      onError: onError,
      setError: setError,
      action: () async {
        final rows = await conn.conn.mappedResultsQuery(sql, substitutionValues: pars);

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

    return result ?? [];
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
