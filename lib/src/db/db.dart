/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

library fdb;

import 'package:fdark/maker/postgres_maker.dart';
import 'package:fdation/fdation.dart';
import 'package:postgres/postgres.dart';

part 'src/postgres_instance.dart';

part 'instance.dart';
part 'row.dart';
part 'connection_settings.dart';
part 'src/row.dart';
part 'postgres.dart';

abstract class FDB {
  Future<List<FDBRow>> query(
    String sql, {
    FOnError? onError,
    FSetError? setError,
    Map<String, dynamic>? pars,
  });
}
