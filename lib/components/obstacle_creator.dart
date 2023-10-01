import 'dart:math';

import 'package:flame/components.dart';
import 'package:pinball/components/obstacle.dart';
import 'package:pinball/utils/levels_data.dart';

class ObstacleCreator extends TimerComponent with HasGameRef {
  final Random random = Random();
  int obstacleIndex = 0;

  ObstacleCreator() : super(period: 5, repeat: true);

  @override
  void onTick() {
    if (obstacleIndex < levelData.obstacles.length) {
      ObstacleData obstacleData = levelData.obstacles[obstacleIndex];
      game.add(
        Obstacle(
          pos: obstacleData.pos,
          type: obstacleData.type,
          speed: levelData.speed,
        ),
      );
      obstacleIndex++;
    }
  }
}
