import 'package:pinball/components/obstacle.dart';
import 'package:pinball/constants/app_preferences.dart';

class LevelData {
  String levelName;
  List<ObstacleData> obstacles;
  double speed;
  double period;
  LevelData(
      {required this.obstacles,
      this.speed = AppPrefs.baseSpeed,
      this.period = 3,
      this.levelName = ''});

  // TODO: level music
}

class ObstacleData {
  ObstacleData(
      {this.type = ObstacleType.square, this.pos = ObstaclePosition.center});
  ObstacleType type;
  ObstaclePosition pos;
}

LevelData level1Data = LevelData(
    levelName: 'Level 1: Titan',
    obstacles: [
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
    ],
    speed: 300,
    period: 1);

LevelData level2Data = LevelData(
    levelName: 'Level 2: Rhea',
    obstacles: [
      ObstacleData(type: ObstacleType.square, pos: ObstaclePosition.left),
    ],
    speed: 300,
    period: 1);

/*
Moons of Saturn ordered by mass
-------------------------------
Titan
Rhea
Iapetus
Dione
Tethys
Enceladus
Mimas
Phoebe
Hyperion
Janus
Epimetheus
Prometheus
Helene
Atlas
Pan
Daphnis
...
*/
