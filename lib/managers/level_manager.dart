import 'dart:math';

import 'package:flame/components.dart';
import 'package:pinball/components/falling_component.dart';
import 'package:pinball/components/obstacle_creator.dart';
import 'package:pinball/components/star_background_creator.dart';
import 'package:pinball/constants/app_preferences.dart';
import 'package:pinball/constants/levels_data.dart';
import 'package:pinball/constants/sentences.dart';
import 'package:pinball/game.dart';
import 'package:pinball/utils/string_utils.dart';

class LevelManager extends Component with HasGameRef<PinballGame> {
  bool isPaused = true;
  late ObstacleCreator obstacleCreator;
  late LevelData currentLevelDate;
  void startLevel(LevelData levelData, {bool isReplay = false}) async {
    print('startLevel');
    isPaused = true;
    currentLevelDate = levelData;
    isPaused = false;
    if (!isReplay) game.add(StarBackGroundCreator());
    game.add(FallingComponent(
        type: ObstacleType.text,
        speed: AppPrefs.baseSpeed,
        text: (!isReplay)
            ? levelData.levelName
            : insertNewline(
                deathSentences[Random().nextInt(deathSentences.length)],
                AppPrefs.sentenceCharOverflow)));
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
