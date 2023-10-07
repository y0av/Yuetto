import 'package:flame/components.dart';
import 'package:pinball/components/obstacle.dart';
import 'package:pinball/components/obstacle_creator.dart';
import 'package:pinball/components/star_background_creator.dart';
import 'package:pinball/utils/app_preferences.dart';
import 'package:pinball/utils/levels_data.dart';

class LevelManager extends Component with HasGameRef {
  bool isPaused = true;

  void startLevel(LevelData levelData) async {
    isPaused = false;
    game.add(StarBackGroundCreator());
    game.add(FallingComponent(
        type: ObstacleType.text,
        speed: AppPrefs.baseSpeed,
        text: levelData.levelName));
    Future.delayed(const Duration(seconds: AppPrefs.levelStartDelaySec), () {
      game.add(ObstacleCreator(levelData: levelData));
    });
  }
}
