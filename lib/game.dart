import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:pinball/components/obstacle_creator.dart';
import 'package:pinball/components/player.dart';
import 'package:pinball/components/star_background_creator.dart';
import 'package:pinball/components/wall.dart';

class PinballGame extends Forge2DGame with PanDetector, TapDetector {
  late Player player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //camera.viewport.add(FpsTextComponent());
    /*cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    add(cameraComponent);
    world.add(Ball());
    world.addAll(createBoundaries());*/
    player = Player();
    world.add(player);
    add(StarBackGroundCreator());
    add(ObstacleCreator());
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
  void onTapDown(TapDownInfo info) {
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
}
