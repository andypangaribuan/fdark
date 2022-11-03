/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fuse_maker;

class _FuseBaseContext {
  final Request _req;
  Object? _objAuthX;
  Object? _objAuthY;

  late final FuseHeader header = _FuseHeader(_req.headers);

  _FuseBaseContext(this._req);
}
