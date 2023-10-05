import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:pinball/components/player.dart';
import 'package:pinball/game.dart';
import 'package:pinball/utils/app_preferences.dart';
import 'package:pinball/utils/app_theme.dart';
import 'package:pinball/utils/math_utils.dart';

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
    RectangleHitbox obstacle = RectangleHitbox(
      position: getStartingPosition(pos),
      size: Vector2.all(AppPrefs.obstaclesHorizontalSize),
      anchor: Anchor.center,
    )
      ..renderShape = true
      ..paint = AppTheme.error;
    add(obstacle);
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

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    print(' hit');
    if (other is Player) {
      // If the other Collidable is a Player,
      //
      print('Player hit');
      destroy();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    print("onCollisionStart");
  }

  void destroy() {
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
        count: 20,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          acceleration: getRandomVector(),
          speed: getRandomVector(),
          position: position.clone(),
          child: CircleParticle(
            radius: 2,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );

    game.add(particleComponent);
  }
}
