import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pinball/components/falling_component.dart';
import 'package:pinball/components/player_hand.dart';
import 'package:pinball/constants/app_preferences.dart';
import 'package:pinball/constants/app_theme.dart';
import 'package:pinball/game.dart';

enum Direction { none, left, right }

class Player extends PositionComponent
    with HasGameRef<PinballGame>, CollisionCallbacks {
  Direction movement = Direction.none;

  Player();

  @override
  Future<void> onLoad() async {
    position = Vector2(
        game.size.x / 2, game.size.y - AppPrefs.playerYOffsetFromBottom);
    CircleComponent bgCircle = CircleComponent(
      position: Vector2.zero(),
      radius: AppPrefs.horizontalOffset,
      paint: AppTheme.paintCircleStroke,
      anchor: Anchor.center,
    );
    addAll([
      bgCircle,
      PlayerHand(handSide: HandSide.left, player: this),
      PlayerHand(handSide: HandSide.right, player: this)
    ]);
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

  void gotHit(Set<Vector2> intersectionPoints, PositionComponent other,
      HandSide handSide) {
    super.onCollision(intersectionPoints, other);
    // currently not needed but it seems like good practice
    if (other is FallingComponent) {
      Vector2 hitLocalPos = Vector2(intersectionPoints.first.x,
          other.position.y - intersectionPoints.first.y);
      print(
          'Player hit $handSide, ${intersectionPoints.first}, ${other.position}');
      other.takeHit(intersectionPoints.first, handSide, hitLocalPos);
      game.levelManager.gameOver();
    }
  }
}
