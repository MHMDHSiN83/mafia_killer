import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioManager {
  static Future<void> playSimultaneously(String assetPath1, String assetPath2) async {
    final AudioPlayer player1 = AudioPlayer();
    final AudioPlayer player2 = AudioPlayer();

    try {
      // Load audio files
      await player1.setAsset(assetPath1);
      await player2.setAsset(assetPath2);

      // Play both audio files simultaneously
      player1.play();
      player2.play();

      // Set volumes (optional)
      player1.setVolume(0.2);
      player2.setVolume(2.0);

      print('Playing audio 1: $assetPath1');
      print('Playing audio 2: $assetPath2');
    } catch (e) {
      print('Error playing audio: $e');
    }
  }
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Audio Player'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              print('Button pressed');
              await AudioManager.playSimultaneously(
                'assets/audios/intro_music.mp3',
                'assets/audios/clock_ticking.mp3',
              );
            },
            child: Text('Play Audio'),
          ),
        ),
      ),
    );
  }
}
