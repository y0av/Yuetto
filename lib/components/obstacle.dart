import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pinball/game.dart';
import 'package:pinball/utils/app_preferences.dart';

enum ObstacleType { square, bigRect, smallRect }

enum ObstaclePosition { left, right, center }

class Obstacle extends PositionComponent
    with HasGameReference<PinballGame>, CollisionCallbacks {
  Obstacle({required this.type, required this.pos, required this.speed});
  //double startingX = 0;
  final ObstacleType type;
  final ObstaclePosition pos;
  final double speed;

  @override
  Future<void> onLoad() async {
    add(RectangleComponent(
      position: getStartingPosition(pos),
      size: Vector2.all(AppPrefs.obstaclesHorizontalSize),
      anchor: Anchor.center,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    y += speed * dt;
    if (y >= game.size.y + AppPrefs.obstaclesHorizontalSize * 2) {
      removeFromParent();
    }
  }

  void takeHit() {
    //TODO splash graphic, lose and start over
    //game.add(SplashComponent(position: position));
    //game.increaseScore();
  }

  Vector2 getStartingPosition(ObstaclePosition pos) {
    double y = -AppPrefs.obstaclesHorizontalSize;
    double x = game.size.x / 2;
    switch (pos) {
      case ObstaclePosition.left:
        x -= AppPrefs.obstaclesHorizontalSize;
        break;
      case ObstaclePosition.right:
        x += AppPrefs.obstaclesHorizontalSize;
        break;
      case ObstaclePosition.center:
        break;
    }
    return Vector2(x, y);
  }
}
