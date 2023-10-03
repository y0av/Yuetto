import 'package:pinball/components/obstacle.dart';
import 'package:pinball/utils/app_preferences.dart';

class ObstacleData {
  ObstacleData(
      {this.type = ObstacleType.square, this.pos = ObstaclePosition.center});
  ObstacleType type;
  ObstaclePosition pos;
}

class LevelData {
  LevelData(
      {required this.obstacles,
      this.speed = AppPrefs.baseSpeed,
      this.period = 5});
  List<ObstacleData> obstacles;
  double speed;
  double period;

  // TODO: level music
}

LevelData level1Data = LevelData(obstacles: [
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.left),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.right),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.center),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.left),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.left),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.right),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.center),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.left),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.left),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.right),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.center),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.left),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.left),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.right),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.center),
  ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.left),
]);
