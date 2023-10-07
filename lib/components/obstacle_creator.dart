import 'dart:math';

import 'package:flame/components.dart';
import 'package:pinball/components/obstacle.dart';
import 'package:pinball/game.dart';
import 'package:pinball/utils/levels_data.dart';

class ObstacleCreator extends TimerComponent with HasGameRef<PinballGame> {
  final Random random = Random();
  final LevelData levelData;
  int _obstacleIndex = 0;
  List<FallingComponent> addedComponents = [];

  ObstacleCreator({required this.levelData})
      : super(period: levelData.period, repeat: true);

  @override
  void onTick() {
    if (!game.levelManager.isPaused) {
      if (_obstacleIndex < levelData.obstacles.length) {
        ObstacleData obstacleData = levelData.obstacles[_obstacleIndex];
        FallingComponent fallingComponent = FallingComponent(
          pos: obstacleData.pos,
          type: obstacleData.type,
          speed: levelData.speed,
        );
        add(fallingComponent);
        addedComponents.add(fallingComponent);
        _obstacleIndex++;
      }
    }
  }

  void onGameOver() {
    for (FallingComponent component in addedComponents) {
      if (!component.isRemoved) {
        remove(component);
      }
    }
    //remove(this);
  }
}
