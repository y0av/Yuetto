import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pinball/game.dart';

enum Direction { none, left, right }

class Player extends PositionComponent
    with HasGameRef<PinballGame>, CollisionCallbacks {
  static final _paintWhite = Paint()
    ..color = Colors.white24
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;
  static final _paint1 = Paint()..color = Colors.purple;
  static final _paint2 = Paint()..color = Colors.tealAccent;
  static const double _radius = 1;
  static const Offset _offset = Offset(10, 0);
  static double delta = 0.04;
  Direction movement = Direction.none;

  final CameraComponent? cameraComponent;

  Player({this.cameraComponent})
      : super(
          //size: Vector2(10, 10),

          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    double y = 30; //TODO some game.size.y;
    //print('size: ${game.size.y} y: $y');
    position = Vector2(0, y);
    /*width = 5;
    height = 10;
    anchor = Anchor.center;
    angle = 0;*/
  }

  @override
  void update(double dt) {
    if (movement != Direction.none) {
      move(movement);
    }
    //cameraComponent.viewfinder.position = position;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset.zero, _offset.dx, _paintWhite);
    canvas.drawCircle(_offset, _radius, _paint1);
    canvas.drawCircle(-_offset, _radius, _paint2);
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
