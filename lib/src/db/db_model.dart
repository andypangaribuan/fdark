/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fdb;

class FConnectionSettings {
  final Duration lifetime;
  final int maxIdle;
  final int maxOpen;

  FConnectionSettings({
    required this.lifetime,
    required this.maxIdle,
    required this.maxOpen,
  });
}

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
    
    // final val = _dict[key];
    // if (val == null) {
    //   return defaultValue;
    // }

    // if (T == String) {
    //   if (val is String) {
    //     return val as T?;
    //   }

    //   return val.toString() as T?;
    // }

    // if (T == int) {
    //   final dv = defaultValue as int?;
    //   if (val is String) {
    //     return val.toInt(defaultValue: dv) as T?;
    //   }
    //   if (val is int) {
    //     return val as T?;
    //   }
    //   if (val is double) {
    //     return val.toInt() as T?;
    //   }
    //   if (val is bool) {
    //     return (val ? 1 : 0) as T?;
    //   }
    // }

    // if (T == double) {
    //   final dv = defaultValue as double?;
    //   if (val is String) {
    //     return val.toDouble(defaultValue: dv) as T?;
    //   }
    //   if (val is int) {
    //     return val.toDouble() as T?;
    //   }
    //   if (val is double) {
    //     return val as T?;
    //   }
    //   if (val is bool) {
    //     return (val ? 1 : 0) as T?;
    //   }
    // }

    // if (T == bool) {
    //   final dv = defaultValue as bool?;
    //   if (val is String) {
    //     switch (val.trim().toLowerCase()) {
    //       case 'true':
    //       case '1':
    //         return true as T?;

    //       case 'false':
    //       case '0':
    //         return false as T?;

    //       default:
    //         return defaultValue;
    //     }
    //   }
    //   if (val is int || val is double) {
    //     return (val == 1
    //         ? true
    //         : val == 0
    //             ? false
    //             : dv) as T?;
    //   }
    // }

    // if (T == DateTime) {
    //   if (val is DateTime) {
    //     return val as T?;
    //   }

    //   return val ?? defaultValue;
    // }

    // return val;
  }
}
