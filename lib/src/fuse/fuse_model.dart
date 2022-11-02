/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of ffuse;

class _FuseRouteHandler {
  String method;
  String route;
  FFuseHandler handler;
  bool withAuthX;
  bool withAuthY;

  _FuseRouteHandler(this.method, this.route, this.handler, this.withAuthX, this.withAuthY);
}

class FuseResponseModel extends FJsonSerializable {
  Object? data;
  FuseResponseMetaModel meta;

  FuseResponseModel({this.data, required this.meta});

  @override
  Map<String, dynamic> serialize() {
    final keys = ['data'];
    return omitempty(keys, {
      'data': fd.json.convert(data, trimDoubleQuotes: true),
      'meta': meta.serialize(),
    });
  }
}

class FuseResponseMetaModel extends FJsonSerializable {
  int code;
  String status;
  String? message;
  String? address;
  String? error;
  Object? data;
  Map<String, dynamic>? customMeta;

  FuseResponseMetaModel({
    required this.code,
    required this.status,
    this.message,
    this.address,
    this.error,
    this.data,
    this.customMeta,
  });

  @override
  Map<String, dynamic> serialize() {
    final keys = ['message', 'address', 'error', 'data'];
    final serial = omitempty(keys, {
      'code': code,
      'status': status,
      'message': message,
      'address': address,
      'error': error,
      'data': fd.json.convert(data, trimDoubleQuotes: true),
    });

    if (customMeta.isNotEmpty) {
      for (var e in customMeta!.entries) {
        serial[e.key] = fd.json.convert(e.value, trimDoubleQuotes: true);
      }
    }

    return serial;
  }
}

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

    // final val = _dict.get(key, ignoreCase: true);
    // if (val == null) {
    //   return defaultValue;
    // }

    // if (T == String) {
    //   return val as T?;
    // }

    // if (T == int) {
    //   final dv = defaultValue as int?;
    //   return val.toInt(defaultValue: dv) as T?;
    // }

    // if (T == double) {
    //   final dv = defaultValue as double?;
    //   return val.toDouble(defaultValue: dv) as T?;
    // }

    // if (T == double) {
    //   switch (val.trim().toLowerCase()) {
    //     case 'true':
    //     case '1':
    //       return true as T?;

    //     case 'false':
    //     case '0':
    //       return false as T?;

    //     default:
    //       return defaultValue;
    //   }
    // }

    // if (T == DateTime) {
    //   if (val is DateTime) {
    //     return val as T?;
    //   }

    //   return val as T? ?? defaultValue;
    // }

    // return val as T?;
  }
}
