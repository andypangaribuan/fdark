/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of ffuse;

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
