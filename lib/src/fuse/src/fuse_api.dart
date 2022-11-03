/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fuse_maker;

const _jsonHeaders = {
  'content-type': 'application/json',
};

class _FuseAPI implements FuseAPI {
  final int? restPort;
  final int? grpcPort;

  _FuseAPI({this.restPort, this.grpcPort});

  @override
  void serve({required Function(FuseRouter router) routes}) async {
    late final router = _FuseRouter();

    if (restPort != null) {
      routes(router);
      _runShelf(restPort!, router);
    }
  }

  void _runShelf(int port, _FuseRouter fr) async {
    final router = Router();

    for (var routerHandler in fr._routeHandlers) {
      switch (routerHandler.method) {
        case 'get':
          router.get(routerHandler.route, (Request req) async => await _process(req, fr, routerHandler));
          break;
        case 'pos':
          router.post(routerHandler.route, (Request req) async => await _process(req, fr, routerHandler));
          break;
        case 'del':
          router.delete(routerHandler.route, (Request req) async => await _process(req, fr, routerHandler));
          break;
        case 'put':
          router.put(routerHandler.route, (Request req) async => await _process(req, fr, routerHandler));
          break;
        case 'pat':
          router.patch(routerHandler.route, (Request req) async => await _process(req, fr, routerHandler));
          break;
      }
    }

    await shelf_io.serve(router, '0.0.0.0', port);
  }

  Future<Response> _process(Request req, _FuseRouter fr, _FuseRouteHandler routeHandler) async {
    if (routeHandler.withAuthX && fr._handlerAuthX == null) {
      return Response.internalServerError(body: 'unimplemented auth-handler-x');
    }

    final baseCtx = _FuseBaseContext(req);

    for (var e in [routeHandler.withAuthX, routeHandler.withAuthY].entries) {
      if (e.value) {
        final handler = e.key == 0 ? fr._handlerAuthX!.call() : fr._handlerAuthY!.call();
        final ctx = _FuseAuthContext(baseCtx);
        final res = (await handler.handler(ctx) as _FuseAuthResponse);

        if (res._res != null) {
          return sendResponse(res._res!);
        }

        if (!res._isOk) {
          return Response.internalServerError(body: 'wrong implementation auth-handler-${e.key == 0 ? 'x' : 'y'}');
        }

        switch (e.key) {
          case 0:
            baseCtx._objAuthX = res._authData;
            break;

          case 1:
            baseCtx._objAuthY = res._authData;
            break;
        }
      }
    }

    final ctx = _FuseContext(baseCtx);
    final handler = routeHandler.handler()
      ..objAuthX = baseCtx._objAuthX
      ..objAuthY = baseCtx._objAuthY;

    final res = (await handler.handler(ctx) as _FuseResponse);
    return sendResponse(res.res);
  }

  @override
  Response sendResponse(FuseResponseModel res) {
    switch (res.meta.code) {
      case 200:
        return Response.ok(
          fd.json.serialize(res),
          headers: _jsonHeaders,
        );

      case 401:
        return Response.unauthorized(res, headers: {'Content-type': 'application/json'});
    }

    return Response.internalServerError(body: 'unhandled response model');
  }
}
