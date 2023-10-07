import 'package:flame/components.dart';
import 'package:pinball/components/obstacle.dart';
import 'package:pinball/components/obstacle_creator.dart';
import 'package:pinball/components/star_background_creator.dart';
import 'package:pinball/game.dart';
import 'package:pinball/utils/app_preferences.dart';
import 'package:pinball/utils/levels_data.dart';

class LevelManager extends Component with HasGameRef<PinballGame> {
  bool isPaused = true;
  late ObstacleCreator obstacleCreator;
  late LevelData currentLevelDate;

  void startLevel(LevelData levelData, {bool isReplay = false}) async {
    currentLevelDate = levelData;
    isPaused = false;
    if (!isReplay) game.add(StarBackGroundCreator());
    game.add(FallingComponent(
        type: ObstacleType.text,
        speed: AppPrefs.baseSpeed,
        text: levelData.levelName));
    obstacleCreator = ObstacleCreator(levelData: levelData);
    Future.delayed(const Duration(seconds: AppPrefs.levelStartDelaySec), () {
      game.add(obstacleCreator);
    });
  }

  void gameOver() {
    isPaused = true;
    obstacleCreator.onGameOver();
    obstacleCreator.removeFromParent();
    Future.delayed(const Duration(seconds: AppPrefs.betweenPlaysDelaySec), () {
      startLevel(currentLevelDate, isReplay: true);
    });
  }
}
