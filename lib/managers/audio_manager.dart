import 'package:flame_audio/flame_audio.dart';
import 'package:pinball/constants/sounds_data.dart';

class Sound {
  Sound(this.path);
  String path;
}

class AudioManager {
  static final AudioManager _instance = AudioManager._();

  static String currentTrack = '';

  factory AudioManager() {
    return _instance;
  }
  AudioManager._() {
    // TODO: implement constructor
    print('AudioManager created');
    FlameAudio.bgm.initialize();
    loadAllSfx();
  }

  Future<void> loadMusic(String musicPath) async {
    currentTrack = musicPath;
    await FlameAudio.audioCache.load(currentTrack);
  }

  Future<void> loadAllSfx() async {
    await FlameAudio.audioCache.loadAll([popSfx.path]);
  }

  playMusic() {
    FlameAudio.bgm.play(currentTrack);
  }

  playSfx(Sound sfx) {
    FlameAudio.play(sfx.path);
  }
}
