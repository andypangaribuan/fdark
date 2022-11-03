/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

library postgres_maker;

import 'package:fdark/src/db/db.dart';
import 'package:fdation/fdation.dart';

part '../src/db/src/postgres.dart';

FPostgresDB makePostgresDB({
  required FDBInstance Function(FPostgresDB db) newInstance,
  required String host,
  required int port,
  required String name,
  required String user,
  required String password,
  String? scheme,
  FConnectionSettings? settings,
}) =>
    _FPostgresDB(
      newInstance: newInstance,
      host: host,
      port: port,
      name: name,
      user: user,
      password: password,
      scheme: scheme,
      settings: settings,
    );
