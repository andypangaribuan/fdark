/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fuse_maker;

class _FuseRouteHandler {
  String method;
  String route;
  FFuseHandler handler;
  bool withAuthX;
  bool withAuthY;

  _FuseRouteHandler(this.method, this.route, this.handler, this.withAuthX, this.withAuthY);
}
