/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fuse_maker;

class _FuseRouter implements FuseRouter {
  FFuseAuthHandler? _handlerAuthX;
  FFuseAuthHandler? _handlerAuthY;
  final _routeHandlers = <_FuseRouteHandler>[];

  @override
  void setHandlerAuthX(FFuseAuthHandler handler) {
    _handlerAuthX = handler;
  }

  @override
  void setHandlerAuthY(FFuseAuthHandler handler) {
    _handlerAuthY = handler;
  }

  @override
  void add(String ep, FFuseHandler handler, {bool withAuthX = false, bool withAuthY = false}) {
    final idx = ep.indexOf(':');
    if (idx > -1) {
      final method = ep.substring(0, idx);
      final route = ep.substring(idx + 1).trim();
      _routeHandlers.add(_FuseRouteHandler(method, route, handler, withAuthX, withAuthY));
    }
  }
}
