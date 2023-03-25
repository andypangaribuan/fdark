/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fuse_maker;

class _FuseContext implements FuseContext {
  final _FuseBaseContext _ctx;

  @override
  FuseHeader get header => _ctx.header;

  _FuseContext(this._ctx);

  FuseResponseModel _getRes(int code, String status, Object? data, String? message, address, error, Object? metaData, Map<String, dynamic>? customMeta) {
    return FuseResponseModel(
      data: data,
      meta: FuseResponseMetaModel(
        code: code,
        status: status,
        message: message,
        address: address,
        error: error,
        data: metaData,
        customMeta: customMeta,
      ),
    );
  }

  @override
  FuseResponse raw(int code, Object data) {
    return _FuseResponse(FuseResponseModel(
      data: data,
      meta: FuseResponseMetaModel(
        code: code,
        status: '',
      ),
    ));
  }

  @override
  FuseResponse ok(Object? data, {String? message, address, error, Object? metaData, Map<String, dynamic>? customMeta}) {
    return _FuseResponse(_getRes(200, 'success', data, message, address, error, metaData, customMeta));
  }

  @override
  FuseResponse notFound({Object? data, String? message, address, error, Object? metaData, Map<String, dynamic>? customMeta}) {
    return _FuseResponse(_getRes(404, 'not-found', data, message, address, error, metaData, customMeta));
  }
}
