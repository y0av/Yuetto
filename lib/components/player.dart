import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pinball/game.dart';

enum Direction { none, left, right }

class Player extends PositionComponent with HasGameRef<PinballGame> {
  static final _paint = Paint()..color = Colors.purple;
  static double delta = 0.1;
  Direction movement = Direction.none;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    position = Vector2(0, 0);
    width = 5;
    height = 10;
    anchor = Anchor.center;
    angle = 0;
  }

  @override
  void update(double dt) {
    if (movement != Direction.none) {
      move(movement);
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  void move(Direction direction) {
    angle += ((direction == Direction.right) ? delta : delta * -1);
  }

  void startMoving(Direction direction) {
    movement = direction;
  }

  void stopMoving() {
    movement = Direction.none;
  }
}
