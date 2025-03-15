import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();

  final AudioPlayer _musicPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer = AudioPlayer();

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal() {
    _musicPlayer.setReleaseMode(ReleaseMode.loop);
    _effectPlayer.setReleaseMode(ReleaseMode.stop);
  }

  Future<void> playMusic(String assetPath) async {
    await _musicPlayer.setSource(AssetSource(assetPath));
    await _musicPlayer.resume();
  }

  Future<void> stopMusic() async {
    await _musicPlayer.stop();
  }

  Future<void> playClickEffect() async {
    _playEffect('audios/click.mp3');
  }

  Future<void> playNextPageEffect() async {
    _playEffect('audios/next.mp3');
  }

  Future<void> playPrePageEffect() async {
    _playEffect('audios/pre.mp3');
  }

  Future<void> playDeleteEffect() async {
    _playEffect('audios/delete.mp3');
  }

  Future<void> playUpCounterEffect() async {
    _playEffect('audios/click_up_real.wav');
  }

  Future<void> playDownCounterMusic() async {
    _playEffect('audios/click_down_real.wav');
  }

  Future<void> _playEffect(String assetPath) async {
    await _effectPlayer.setSource(AssetSource(assetPath));
    await _effectPlayer.resume();
  }

  void disposeMusic() {
    _musicPlayer.dispose();
  }

  void disposeEffect() {
    _effectPlayer.dispose();
  }
}
