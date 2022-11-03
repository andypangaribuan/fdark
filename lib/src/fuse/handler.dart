/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of ffuse;

abstract class FuseHandler {
  Object? objAuthX;
  Object? objAuthY;
  Future<FuseResponse> handler(FuseContext ctx);
}
