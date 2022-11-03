/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of postgres_maker;

class _FPostgresDB implements FPostgresDB {
  late final FDBInstance Function(FPostgresDB db) _newInstance;

  @override
  final String host;
  @override
  final int port;
  @override
  final String name;
  @override
  final String user;
  @override
  final String password;

  @override
  late final String scheme;
  @override
  late final FConnectionSettings settings;

  late final _pool = FPool<FDBInstance>(
    newInstance: () => _newInstance(this),
    maxConcurrent: 0,
    maxIdle: settings.maxIdle,
    maxOpen: settings.maxOpen,
    openLifetime: settings.openLifetime,
  );
  Future<FDBInstance> get _instance => _pool.instance;

  _FPostgresDB({
    required FDBInstance Function(FPostgresDB db) newInstance,
    required this.host,
    required this.port,
    required this.name,
    required this.user,
    required this.password,
    String? scheme,
    FConnectionSettings? settings,
  }) {
    _newInstance = newInstance;
    this.scheme = scheme ?? 'public';
    this.settings = settings ??
        FConnectionSettings(
          maxIdle: 5,
          maxOpen: 10,
          idleLifetime: Duration(minutes: 30),
          openLifetime: Duration(minutes: 5),
        );
  }

  @override
  Future<List<FDBRow>> query(String sql, {FOnError? onError, FSetError? setError, Map<String, dynamic>? pars}) async {
    final instance = await _instance;
    final res = await instance.query(sql, onError: onError, setError: setError, pars: pars);
    instance.release();
    return res;
  }
}
