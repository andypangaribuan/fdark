/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fdb;

class _FDBRow extends FDBRow {
  final Map<String, dynamic> _dict;

  _FDBRow(this._dict);

  @override
  operator [](String key) => _dict[key];

  @override
  operator []=(String key, dynamic value) => _dict[key] = value;

  @override
  T? get<T>(String key, {T? defaultValue}) {
    return fd.convert.to<T>(_dict[key], defaultValue: defaultValue);
  }
}

class _FDBResponse<T> extends FDBResponse<T> {
  final FError _err;
  final T _data;

  @override
  FError get err => _err;

  @override
  T get data => _data;

  _FDBResponse(this._err, this._data);
}
