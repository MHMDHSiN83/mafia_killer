import 'package:just_audio/just_audio.dart';
import 'package:mafia_killer/databases/game_settings.dart';

class AudioManager {
  static final AudioPlayer _musicPlayer = AudioPlayer();
  static final AudioPlayer _effectPlayer = AudioPlayer();
  static final AudioPlayer _clockTickingPlayer = AudioPlayer();
  static Duration? _savedPosition;

  static Future<void> playNightMusic() async {
    await _playMusic('assets/audios/Dark-Legacy.mp3');
  }

  static Future<void> setPlayerAsset() async {
    await _clockTickingPlayer.setAsset('assets/audios/clock_tickin.mp3');
  }

  static Future<void> playIntroMusic() async {
    await _playMusic('assets/audios/intro_music.mp3');
  }

  static Future<void> _playMusic(String assetPath) async {
    if (GameSettings.currentGameSettings.playMusic) {
      await _musicPlayer.setAsset(assetPath);
      await _musicPlayer.setLoopMode(LoopMode.one);
      _musicPlayer.play();
    }
  }

  static Future<void> _playClockTicking(String assetPath) async {
    if (GameSettings.currentGameSettings.playMusic) {
      if (_clockTickingPlayer.processingState == ProcessingState.completed) {
        await _clockTickingPlayer.seek(Duration.zero);
      } else {
        if (_savedPosition != null) {
          await _clockTickingPlayer.seek(_savedPosition!);
        } else {
          await _clockTickingPlayer.seek(Duration.zero);
        }
      }

      await _clockTickingPlayer.play();
    }
  }

  static Future<void> resetClockTicking() async {
    _savedPosition = null;
  }

  static Future<void> stopMusic() async {
    await _musicPlayer.stop();
  }

  static void savePosition() {
    _savedPosition = _clockTickingPlayer.position;
  }

  static Future<void> stopClockTicking() async {
    savePosition();
    await _clockTickingPlayer.stop();
  }

  static Future<void> playClickEffect() async {
    await _playEffect('assets/audios/click.mp3');
  }

  static Future<void> playNextPageEffect() async {
    await _playEffect('assets/audios/next.mp3');
  }

  static Future<void> playPrePageEffect() async {
    await _playEffect('assets/audios/pre.mp3');
  }

  static Future<void> playDeleteEffect() async {
    await _playEffect('assets/audios/delete.mp3');
  }

  static Future<void> playUpCounterEffect() async {
    await _playEffect('assets/audios/click_up_real.wav');
  }

  static Future<void> playDownCounterEffect() async {
    await _playEffect('assets/audios/click_down_real.wav');
  }

  static Future<void> playSnackBarEffect() async {
    await _playEffect('assets/audios/snackbar.mp3');
  }

  static Future<void> playVotingTileStampEffect() async {
    await _playEffect('assets/audios/mohr.mp3');
  }

  static Future<void> playClockTicking() async {
    await _playClockTicking('assets/audios/clock_tickin.mp3');
  }

  static Future<void> _playEffect(String assetPath) async {
    if (GameSettings.currentGameSettings.soundEffect) {
      await _effectPlayer.setAsset(assetPath);
      _effectPlayer.play();
    }
  }

  void disposeMusic() {
    _musicPlayer.dispose();
  }

  void disposeEffect() {
    _effectPlayer.dispose();
  }
}
