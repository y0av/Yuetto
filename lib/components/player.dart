import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pinball/game.dart';
import 'package:pinball/utils/app_preferences.dart';
import 'package:pinball/utils/app_theme.dart';

enum Direction { none, left, right }

class Player extends PositionComponent
    with HasGameRef<PinballGame>, CollisionCallbacks {
  Direction movement = Direction.none;

  final CameraComponent? cameraComponent;

  Player({this.cameraComponent});

  @override
  Future<void> onLoad() async {
    double y = 20; //TODO some game.size.y;
    //print('size: ${game.size.y} y: $y');
    position = Vector2(0, y);
    /*width = 5;
    height = 10;
    anchor = Anchor.center;
    angle = 0;*/
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
    addAll([lCircle, rCircle]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (movement != Direction.none) {
      move(movement);
    }
    //cameraComponent.viewfinder.position = position;
  }

/*  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
        Offset.zero, AppPrefs.offset.dx, AppTheme.paintCircleStroke);
    canvas.drawCircle(
        Offset(
            AppPrefs.offset.dx - AppTheme.strokeWidth / 2, AppPrefs.offset.dy),
        AppPrefs.radius,
        AppTheme.paint1);
    canvas.drawCircle(-AppPrefs.offset, AppPrefs.radius, AppTheme.paint2);
  }*/

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
