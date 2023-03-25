/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of ffuse;

abstract class FuseAuthContext {
  FuseHeader get header;

  FuseAuthResponse ok(Object? data);

  FuseAuthResponse unauthorized({Object? data, String? message, address, error, Object? metaData});
}

abstract class FuseContext {
  FuseHeader get header;

  FuseResponse raw(int code, Object data);

  FuseResponse ok(Object? data, {String? message, address, error, Object? metaData, Map<String, dynamic>? customMeta});

  FuseResponse notFound({Object? data, String? message, address, error, Object? metaData, Map<String, dynamic>? customMeta});
}
