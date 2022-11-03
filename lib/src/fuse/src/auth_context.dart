/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fuse_maker;

class _FuseAuthContext implements FuseAuthContext {
  final _FuseBaseContext _ctx;

  @override
  FuseHeader get header => _ctx.header;

  _FuseAuthContext(this._ctx);

  @override
  FuseAuthResponse ok(Object? data) {
    return _FuseAuthResponse(isOk: true, authData: data);
  }

  @override
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

    return _FuseAuthResponse(res: res);
  }
}
