/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of ffuse;

class _FuseBaseContext {
  final Request _req;
  Object? _objAuthX;
  Object? _objAuthY;

  late final FuseHeader header = _FuseHeader(_req.headers);

  _FuseBaseContext(this._req);
}

class FuseAuthContext {
  final _FuseBaseContext _ctx;

  FuseHeader get header => _ctx.header;

  FuseAuthContext._(this._ctx);

  FuseAuthResponse ok(Object? data) {
    return FuseAuthResponse._(isOk: true, authData: data);
  }

  FuseAuthResponse unauthorized({Object? data, String? message, address, error, Object? metaData}) {
    final res = FuseResponseModel(
      data: data,
      meta: FuseResponseMetaModel(
        code: 401,
        status: 'unauthorized',
        message: message,
        address: address,
        error: error,
        data: metaData,
      ),
    );

    return FuseAuthResponse._(res: res);
  }
}

class FuseContext {
  final _FuseBaseContext _ctx;

  FuseHeader get header => _ctx.header;

  FuseContext._(this._ctx);

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

  FuseResponse ok(Object? data, {String? message, address, error, Object? metaData, Map<String, dynamic>? customMeta}) {
    return FuseResponse._(_getRes(200, 'success', data, message, address, error, metaData, customMeta));
  }

  FuseResponse notFound({Object? data, String? message, address, error, Object? metaData, Map<String, dynamic>? customMeta}) {
    return FuseResponse._(_getRes(404, 'not-found', data, message, address, error, metaData, customMeta));
  }
}
