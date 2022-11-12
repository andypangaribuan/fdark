/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fdb;


class _FPostgresTransaction extends FDBTransaction {
  _FPostgresInstance Function() instance;

  _FPostgresTransaction(this.instance);

  @override
  Future<FError> execute({required String sql, Map<String, dynamic>? pars}) async {
    return await instance().execute(sql: sql, pars: pars);
  }

  @override
  Future<FDBResponse<FDBRow?>> executeReturn({required String sql, Map<String, dynamic>? pars}) async {
    return await instance().executeReturn(sql: sql, pars: pars);
  }

  @override
  Future<FDBResponse<List<FDBRow>>> select({required String sql, Map<String, dynamic>? pars}) async {
    return await instance().select(sql: sql, pars: pars);
  }
  
  @override
  void cancel({String? reason}) {
    instance().transactionCtx?.cancelTransaction(reason: reason);
  }
  
}