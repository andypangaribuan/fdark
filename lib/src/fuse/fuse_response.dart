/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of ffuse;

class FuseAuthResponse {
  bool _isOk = false;
  Object? _authData;
  FuseResponseModel? _res;

  FuseAuthResponse._({bool isOk = false, Object? authData, FuseResponseModel? res}) {
    _isOk = isOk;
    _authData = authData;
    _res = res;
  }
}

class FuseResponse {
  final FuseResponseModel _res;

  FuseResponse._(FuseResponseModel res) : _res = res;
}
