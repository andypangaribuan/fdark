/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fdb;

Map<String, dynamic> _transformPars(Map<String, dynamic>? pars) {
  if (pars == null) {
    return {};
  }

  return _transformObject(pars);
}

dynamic _transformObject(dynamic obj) {
  if (obj == null) {
    return obj;
  }

  if (obj is List) {
    obj.loop((item, idx) => obj[idx] = _transformObject(item));
  }

  if (obj is Map) {
    obj.loop((key, val) => obj[key] = _transformObject(val));
  }

  if (obj is Decimal) {
    return obj.toString();
  }

  return obj;
}
