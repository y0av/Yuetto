import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:pinball/components/ball.dart';
import 'package:pinball/components/player.dart';
import 'package:pinball/components/star_background_creator.dart';
import 'package:pinball/components/wall.dart';

class PinballGame extends Forge2DGame with TapDetector {
  late Player player;
  late final CameraComponent cameraComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //camera.viewport.add(FpsTextComponent());
    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    add(cameraComponent);
    world.add(Ball());
    world.addAll(createBoundaries());
    player = Player();
    world.add(player);
    add(StarBackGroundCreator());
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
  void onTapDown(_info) {
    if (_info.eventPosition.viewport.x > size.x / 2) {
      //debugPrint('right');
      player.startMoving(Direction.right);
    } else {
      //debugPrint('left');
      player.startMoving(Direction.left);
    }
  }

  @override
  void onTapUp(TapUpInfo info) {
    player.stopMoving();
  }

  @override
  void onTapCancel() {
    player.stopMoving();
  }
}
