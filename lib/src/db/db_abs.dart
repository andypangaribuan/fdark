/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fdb;

abstract class FDB {
  Future<List<FDBRow>> query(String sql, {FOnError? onError, FSetError? setError, Map<String, dynamic>? pars});
}

abstract class FDBInstance extends FPoolInstance {
  Future<List<FDBRow>> query(String sql, {FOnError? onError, FSetError? setError, Map<String, dynamic>? pars});
}

abstract class FDBRow {
  operator [](String key);
  operator []=(String key, dynamic value);

  T? get<T>(String key, {T? defaultValue});
}
