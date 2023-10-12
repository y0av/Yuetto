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

/*class _Rectangle extends CircleComponent {
  _Rectangle()
      : super(
          //position: Vector2(200, 200),
          radius: 50,
          anchor: Anchor.center,
          paint: AppTheme.paint2,
        );
}*/

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
      List<CircleComponent> splashComponents = [];
      for (HitData hitData in obstacleRef!.hits) {
        Vector2 hitPos = Vector2(
            obstacleRef!.obstacleSize.x / 2 +
                hitData.hitLocalPos.x -
                getStartingPosition(pos).x +
                game.size.x / 2,
            // can be 3/2 * obstacleRef!.obstacleSize.y - hitData.hitLocalPos.y but that's harder to understand
            obstacleRef!.obstacleSize.y -
                (hitData.hitLocalPos.y - obstacleRef!.obstacleSize.y / 2));
        // print('hit pos: $hitPos local: ${hitData.hitLocalPos}');
        CircleComponent splashTest = CircleComponent(
          position: hitPos,
          radius: AppPrefs.splashRadius,
          paint: (hitData.handSide == HandSide.left)
              ? AppTheme.paint1Splash
              : AppTheme.paint2Splash,
          anchor: Anchor.center,
        );
        splashComponents.add(splashTest);
      }
      add(ClipComponent.rectangle(
        position: getStartingPosition(pos),
        size: obstacleRef!.obstacleSize,
        anchor: Anchor.center,
        children: splashComponents,
      ));
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
    // Ask audio player to play death
    /*game.addCommand(Command<AudioPlayerComponent>(action: (audioPlayer) {
      audioPlayer.playSfx('laser1.ogg');
    }));*/

    // Before dying, register a command to increase
    // player's score by 1.
    /*final command = Command<Player>(action: (player) {
      // Use the correct killPoint to increase player's score.
      player.addToScore(enemyData.killPoint);
    });
    game.addCommand(command);*/

    // Generate 60 circle particles with random speed and acceleration,
    // at current position of this obstacle. Each particles lives for exactly
    // 2 seconds and will get removed from the game world after that.
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
