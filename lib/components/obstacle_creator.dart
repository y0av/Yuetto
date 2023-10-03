import 'dart:math';

import 'package:flame/components.dart';
import 'package:pinball/components/obstacle.dart';
import 'package:pinball/utils/levels_data.dart';

class ObstacleCreator extends TimerComponent with HasGameRef {
  final Random random = Random();
  final LevelData levelData;
  int _obstacleIndex = 0;

  ObstacleCreator({required this.levelData})
      : super(period: levelData.period, repeat: true);

  @override
  void onTick() {
    if (_obstacleIndex < levelData.obstacles.length) {
      ObstacleData obstacleData = levelData.obstacles[_obstacleIndex];
      game.add(
        Obstacle(
          pos: obstacleData.pos,
          type: obstacleData.type,
          speed: levelData.speed,
        ),
      );
      _obstacleIndex++;
    }
  }
}
