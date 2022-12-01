/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

library ffuse;

import 'package:fdark/maker/fuse_maker.dart';
import 'package:fdation/fdation.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:shelf/shelf.dart';

part 'alias.dart';
part 'auth_handler.dart';
part 'fuse_context.dart';
part 'handler.dart';
part 'header.dart';
part 'response_model.dart';
part 'response.dart';
part 'router.dart';

abstract class FuseAPI {
  factory FuseAPI({int? restPort, int? grpcPort}) => makeAPI(restPort: restPort, grpcPort: grpcPort);

  Future<void> restfulService({required Function(FuseRouter router) routes});
  Future<void> grpcServices({required List<grpc.Service> services});

  Response sendResponse(FuseResponseModel res);
}
