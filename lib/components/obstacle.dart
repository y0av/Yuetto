import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:pinball/components/player_hand.dart';
import 'package:pinball/game.dart';
import 'package:pinball/utils/app_preferences.dart';
import 'package:pinball/utils/app_theme.dart';
import 'package:pinball/utils/math_utils.dart';

enum ObstacleType { text, square, bigRect, smallRect }

enum ObstaclePosition { left, right, center }

class FallingComponent extends PositionComponent
    with HasGameReference<PinballGame>, CollisionCallbacks {
  FallingComponent(
      {required this.type,
      this.pos = ObstaclePosition.center,
      required this.speed,
      this.text = ''});
  //double startingX = 0;
  final text;
  final ObstacleType type;
  final ObstaclePosition pos;
  final double speed;

  @override
  Future<void> onLoad() async {
    dynamic component;
    switch (type) {
      case ObstacleType.text:
        component = TextComponent(
          position: getStartingPosition(pos),
          text: text,
          anchor: Anchor.center,
        );
        break;
      case ObstacleType.square:
        component = RectangleHitbox(
          position: getStartingPosition(pos),
          size: Vector2.all(AppPrefs.obstaclesHorizontalSize),
          anchor: Anchor.center,
        )
          ..renderShape = true
          ..paint = AppTheme.paint3;
        break;
      case ObstacleType.bigRect:
      // TODO: Handle this case.
      case ObstacleType.smallRect:
      // TODO: Handle this case.
    }

    add(component);
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

  // Called from player
  void destroy(Vector2 intersectionPoint, HandSide handSide) {
    removeFromParent();
    // Ask audio player to play enemy destroy effect.
    /*game.addCommand(Command<AudioPlayerComponent>(action: (audioPlayer) {
      audioPlayer.playSfx('laser1.ogg');
    }));

    // Before dying, register a command to increase
    // player's score by 1.
    final command = Command<Player>(action: (player) {
      // Use the correct killPoint to increase player's score.
      player.addToScore(enemyData.killPoint);
    });
    game.addCommand(command);*/

    // Generate 20 white circle particles with random speed and acceleration,
    // at current position of this enemy. Each particles lives for exactly
    // 0.1 seconds and will get removed from the game world after that.
    final particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        count: 60,
        lifespan: 2,
        generator: (i) => AcceleratedParticle(
          acceleration: getRandomVector(),
          speed: getRandomVector(),
          position: intersectionPoint.clone(),
          child: CircleParticle(
            radius: 2,
            paint:
                (handSide == HandSide.left) ? AppTheme.paint1 : AppTheme.paint2,
          ),
        ),
      ),
    );

    game.add(particleComponent);
  }
}
