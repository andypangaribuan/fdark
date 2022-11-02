/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fdb;

class FPostgresDB extends FDB {
  final String host;
  final int port;
  final String name;
  final String user;
  final String password;
  late final String scheme;
  late final FConnectionSettings settings;
  late final _pool = FPool<_FPostgresInstance>(
    newInstance: () => _FPostgresInstance(this),
    maxConcurrent: 0,
    maxIdle: settings.maxIdle,
    maxOpen: settings.maxOpen,
  );
  Future<_FPostgresInstance> get _instance => _pool.instance;

  FPostgresDB({
    required this.host,
    required this.port,
    required this.name,
    required this.user,
    required this.password,
    String? scheme,
    FConnectionSettings? settings,
  }) {
    this.scheme = scheme ?? 'public';
    this.settings = settings ??
        FConnectionSettings(
          lifetime: Duration(minutes: 30),
          maxIdle: 5,
          maxOpen: 10,
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
