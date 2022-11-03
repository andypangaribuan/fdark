/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of ffuse;

abstract class FuseHeader {
  operator [](String key);
  operator []=(String key, String value);

  T? get<T>(String key, {T? defaultValue});
}
