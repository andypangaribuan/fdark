/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fdb;

abstract class FPostgresDB extends FDB {
  String get host;
  int get port;
  String get name;
  String get user;
  String get password;
  String get scheme;
  FConnectionSettings get settings;

  factory FPostgresDB({
    required String host,
    required int port,
    required String name,
    required String user,
    required String password,
    String? scheme,
    FConnectionSettings? settings,
  }) =>
      makePostgresDB(
        newInstance: (db) => _FPostgresInstance(db),
        host: host,
        port: port,
        name: name,
        user: user,
        password: password,
        scheme: scheme,
        settings: settings,
      );
}
