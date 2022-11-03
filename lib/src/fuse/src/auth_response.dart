/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fuse_maker;

class _FuseAuthResponse implements FuseAuthResponse {
  bool _isOk = false;
  Object? _authData;
  FuseResponseModel? _res;

  _FuseAuthResponse({bool isOk = false, Object? authData, FuseResponseModel? res}) {
    _isOk = isOk;
    _authData = authData;
    _res = res;
  }
}
