import 'package:flame/components.dart';
import 'package:pinball/game.dart';

class StarComponent extends SpriteAnimationComponent
    with HasGameRef<PinballGame> {
  static const speed = 10;

  StarComponent({super.animation, super.position})
      : super(size: Vector2.all(20));

  @override
  void update(double dt) {
    super.update(dt);
    y += dt * speed;
    if (y >= game.size.y) {
      removeFromParent();
    }
  }
}
