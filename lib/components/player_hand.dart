import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pinball/components/player.dart';
import 'package:pinball/utils/app_preferences.dart';
import 'package:pinball/utils/app_theme.dart';

enum HandSide { left, right }

class PlayerHand extends PositionComponent with CollisionCallbacks {
  PlayerHand({required this.handSide}) : super();

  HandSide handSide;

  @override
  Future<void> onLoad() async {
    CircleHitbox hand = CircleHitbox(
      position: Vector2(
          (handSide == HandSide.left)
              ? -AppPrefs.horizontalOffset
              : AppPrefs.horizontalOffset,
          0),
      radius: AppPrefs.radius,
      anchor: Anchor.center,
    )
      ..renderShape = true
      ..paint = (handSide == HandSide.left) ? AppTheme.paint1 : AppTheme.paint2;
    add(hand);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    (parent as Player).gotHit(intersectionPoints, other, handSide);
  }
}
