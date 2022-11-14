/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

library fdb;

import 'package:decimal/decimal.dart';
import 'package:fdark/maker/postgres_maker.dart';
import 'package:fdation/fdation.dart';
import 'package:postgres/postgres.dart';

part 'src/model.dart';
part 'src/postgres_instance.dart';
part 'src/postgres_transaction.dart';
part 'src/utilities.dart';

part 'connection_settings.dart';
part 'instance.dart';
part 'model.dart';
part 'postgres.dart';
part 'transaction.dart';

abstract class FDB {
  Future<FError> execute({
    required String sql,
    Map<String, dynamic>? pars,
  });

  Future<FDBRowResponse> executeReturn({
    required String sql,
    Map<String, dynamic>? pars,
  });

  Future<FDBListRowResponse> select({
    required String sql,
    Map<String, dynamic>? pars,
  });

  Future<FDBResponse<T?>> transaction<T>(Future<T?> Function(FDBTransaction trx) callback);
}
