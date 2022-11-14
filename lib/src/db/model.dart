/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fdb;

abstract class FDBRow {
  operator [](String key);
  operator []=(String key, dynamic value);

  T? get<T>(String key, {T? defaultValue});
}

abstract class FDBResponse<T> {
  FError get err;
  T get data;
}

abstract class FDBRowResponse {
  FError get err;
  FDBRow? get row;
}

abstract class FDBListRowResponse {
  FError get err;
  List<FDBRow> get rows;
}
