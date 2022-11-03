/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

library fuse_maker;

import 'package:fdark/src/fuse/fuse_api.dart';
import 'package:fdation/fdation.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

part '../src/fuse/src/auth_context.dart';
part '../src/fuse/src/auth_response.dart';
part '../src/fuse/src/base_context.dart';
part '../src/fuse/src/context.dart';
part '../src/fuse/src/fuse_api.dart';
part '../src/fuse/src/header.dart';
part '../src/fuse/src/response.dart';
part '../src/fuse/src/route_handler.dart';
part '../src/fuse/src/router.dart';

FuseAPI makeAPI({
  int? restPort,
  int? grpcPort,
}) =>
    _FuseAPI(
      restPort: restPort,
      grpcPort: grpcPort,
    );
