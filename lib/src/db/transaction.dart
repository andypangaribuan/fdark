/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fdb;

abstract class FDBTransaction {
  Future<FError> execute({
    required String sql,
    Map<String, dynamic>? pars,
  });

  Future<FDBResponse<FDBRow?>> executeReturn({
    required String sql,
    Map<String, dynamic>? pars,
  });

  Future<FDBResponse<List<FDBRow>>> select({
    required String sql,
    Map<String, dynamic>? pars,
  });

  void cancel({String? reason});
}
