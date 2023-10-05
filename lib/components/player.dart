import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pinball/game.dart';
import 'package:pinball/utils/app_preferences.dart';
import 'package:pinball/utils/app_theme.dart';

enum Direction { none, left, right }

class Player extends PositionComponent
    with HasGameRef<PinballGame>, CollisionCallbacks {
  Direction movement = Direction.none;

  Player();

  @override
  Future<void> onLoad() async {
    position = Vector2(game.size.x / 2, game.size.y - 200);
    CircleComponent bgCircle = CircleComponent(
      position: Vector2.zero(),
      radius: AppPrefs.horizontalOffset,
      paint: AppTheme.paintCircleStroke,
      anchor: Anchor.center,
    );
    CircleHitbox rCircle = CircleHitbox(
      position: Vector2(AppPrefs.horizontalOffset, 0),
      radius: AppPrefs.radius,
      anchor: Anchor.center,
    )
      ..renderShape = true
      ..paint = AppTheme.error;
    CircleHitbox lCircle = CircleHitbox(
      position: Vector2(-AppPrefs.horizontalOffset, 0),
      radius: AppPrefs.radius,
      anchor: Anchor.center,
    )
      ..renderShape = true
      ..paint = AppTheme.paint2;
    addAll([bgCircle, lCircle, rCircle]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (movement != Direction.none) {
      move(movement);
    }
  }

  void move(Direction direction) {
    angle +=
        ((direction == Direction.right) ? AppPrefs.delta : AppPrefs.delta * -1);
  }

  void startMoving(Direction direction) {
    movement = direction;
  }

  void stopMoving() {
    movement = Direction.none;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    print(' in player hit');
  }
}
