import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:pinball/components/player_hand.dart';
import 'package:pinball/constants/app_preferences.dart';
import 'package:pinball/constants/app_theme.dart';
import 'package:pinball/constants/levels_data.dart';
import 'package:pinball/game.dart';
import 'package:pinball/utils/math_utils.dart';

enum ObstacleType { text, square, bigRect, smallRect }

enum ObstaclePosition { left, right, center }

class FallingComponent extends PositionComponent
    with HasGameRef<PinballGame>, CollisionCallbacks {
  FallingComponent(
      {required this.type,
      this.pos = ObstaclePosition.center,
      required this.speed,
      this.text = '',
      this.obstacleRef});
  //double startingX = 0;
  final String text;
  final ObstacleType type;
  final ObstaclePosition pos;
  final double speed;
  final ObstacleData? obstacleRef;

  @override
  Future<void> onLoad() async {
    dynamic component;
    switch (type) {
      case ObstacleType.text:
        component = TextComponent(
          //size: Vector2(game.size.y, game.size.x),
          textRenderer: AppTheme.regularTextPaint,
          position: getStartingPosition(pos),
          text: text,
          anchor: Anchor.center,
        );
        break;
      case ObstacleType.square:
        //print('rect pos ${getStartingPosition(pos)}');
        component = RectangleHitbox(
          position: getStartingPosition(pos),
          size: obstacleRef!.obstacleSize,
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
    if (obstacleRef != null) {
      for (HitData hitData in obstacleRef!.hits) {
        Vector2 hitPos = Vector2(
            hitData.hitLocalPos.x,
            //-obstacleRef!.obstacleSize.y / 2 -
            -hitData.hitLocalPos.y +
                //obstacleRef!.obstacleSize.y -
                -3);
        //print('hitPos: $hitPos');
        CircleComponent splashTest = CircleComponent(
          position: hitPos,
          radius: 3,
          paint: (hitData.handSide == HandSide.left)
              ? AppTheme.paint1
              : AppTheme.paint2,
        );
        add(splashTest);
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    y += speed * dt;
    if (y >= game.size.y + AppPrefs.obstaclesHorizontalSize * 2) {
      removeFromParent();
    }
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
  void takeHit(
      Vector2 intersectionPoint, HandSide handSide, Vector2 hitLocalPos) {
    if (obstacleRef != null) {
      obstacleRef!.hits
          .add(HitData(handSide: handSide, hitLocalPos: hitLocalPos));
    }
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
