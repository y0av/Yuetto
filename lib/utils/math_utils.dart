import 'dart:math';

import 'package:flame/components.dart';

final _random = Random();
Vector2 getRandomVector() {
  return (Vector2.random(_random) - Vector2.random(_random)) * 500;
}

Vector2 getRandomDirection() {
  return (Vector2.random(_random) - Vector2(0.5, -1)).normalized();
}
