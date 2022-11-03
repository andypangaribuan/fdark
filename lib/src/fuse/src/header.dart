/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fuse_maker;

class _FuseHeader extends FuseHeader {
  final Map<String, String> _dict;

  _FuseHeader(this._dict);

  @override
  operator [](String key) => _dict.get(key, ignoreCase: true);

  @override
  operator []=(String key, String value) => _dict[key] = value;

  @override
  T? get<T>(String key, {T? defaultValue}) {
    return fd.convert.to<T>(_dict.get(key, ignoreCase: true), defaultValue: defaultValue);
  }
}
