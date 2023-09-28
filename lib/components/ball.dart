import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Ball extends BodyComponent with TapCallbacks {
  final Vector2 initialPosition;

  Ball({Vector2? initialPosition})
      : initialPosition = initialPosition ?? Vector2.zero();

  @override
  Body createBody() {
    final shape = CircleShape();
    shape.radius = 5;

    final fixtureDef = FixtureDef(
      shape,
      restitution: 0.8,
      density: 1.0,
      friction: 0.4,
    );

    final bodyDef = BodyDef(
      userData: this,
      angularDamping: 0.8,
      position: initialPosition,
      type: BodyType.dynamic,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void onTapDown(_) {
    body.applyForce(Vector2(1, -1) * 1000000);
  }
}
