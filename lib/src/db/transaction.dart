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

  Future<FDBRowResponse> executeReturn({
    required String sql,
    Map<String, dynamic>? pars,
  });

  Future<FDBListRowResponse> select({
    required String sql,
    Map<String, dynamic>? pars,
  });

  void cancel({String? reason});
}
