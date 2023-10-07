import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:pinball/components/player.dart';
import 'package:pinball/components/wall.dart';
import 'package:pinball/constants/levels_data.dart';
import 'package:pinball/managers/level_manager.dart';

class PinballGame extends FlameGame
    with PanDetector, MultiTouchTapDetector, HasCollisionDetection {
  late Player player;
  LevelManager levelManager = LevelManager();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(levelManager);
    openMenu();
  }

  void openMenu() {
    overlays.add('menu');
  }

  List<Component> createBoundaries() {
    final visibleRect = camera.visibleWorldRect;
    final topLeft = visibleRect.topLeft.toVector2();
    final topRight = visibleRect.topRight.toVector2();
    final bottomRight = visibleRect.bottomRight.toVector2();
    final bottomLeft = visibleRect.bottomLeft.toVector2();

    return [
      Wall(topLeft, topRight),
      Wall(topRight, bottomRight),
      Wall(bottomLeft, bottomRight),
      Wall(topLeft, bottomLeft),
    ];
  }

  @override
  void onPanEnd(info) {
    player.stopMoving();
  }

  @override
  void onPanCancel() {
    player.stopMoving();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    spinPlayer(info.eventPosition.viewport.x, size.x);
  }

  @override
  void onTapDown(i, info) {
    spinPlayer(info.eventPosition.viewport.x, size.x);
  }

  void spinPlayer(double x, double screenWidth) {
    if (x > screenWidth / 2) {
      //debugPrint('right');
      player.startMoving(Direction.right);
    } else {
      //debugPrint('left');
      player.startMoving(Direction.left);
    }
  }

  void startLevel(LevelData levelData) {
    overlays.remove('menu');
    player = Player();
    add(player);
    levelManager.startLevel(levelData);
  }
}
