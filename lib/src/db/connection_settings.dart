/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of fdb;

class FConnectionSettings {
  final int maxIdle;
  final int maxOpen;
  final Duration idleLifetime;
  final Duration openLifetime;

  FConnectionSettings({
    required this.maxIdle,
    required this.maxOpen,
    required this.idleLifetime,
    required this.openLifetime,
  });
}
