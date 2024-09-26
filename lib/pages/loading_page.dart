import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/models/isar_service.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void getGameSettingsData() async {
    final isar = await IsarService.db;
    GameSettings? gameSettings = await isar.gameSettings.get(1);
    gameSettings!.scenario.loadSync();
    Map<String, dynamic> newGameSettings = gameSettings.getSettingsInMap();
    Navigator.pushReplacementNamed(context, '/game_settings_page', arguments: {
      'newGameSettings': newGameSettings,
      'gameSettings': gameSettings,
    });
  }

  @override
  void initState() {
    super.initState();
    getGameSettingsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(17, 7, 7, 1),
            Color.fromRGBO(40, 7, 7, 1),
            // Color(0xFF111111),
            // Color(0xFF3F0000)
          ],
        )),
        child: Center(
          child: SpinKitSpinningLines(
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 100.0,
            lineWidth: 7,
          ),
        ),
      ),
    );
  }
}
