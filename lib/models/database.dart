import 'dart:convert';
import 'dart:io';

import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/page_guide.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/recommended_scenario.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/databases/scenario_guide.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:path_provider/path_provider.dart';

class Database {
  static late String playersDataFilePath;
  static late String scenariosDataFilePath;
  static late String gameSettingsDataFilePath;

  static Future<String> getDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<void> setInitialValues() async {
    await Scenario.getScenariosFromDatabase();
    await GameSettings.getGameSettingsFromDatabase();
    await Player.getPlayersFromDatabase();
    await PageGuide.getGuidesFromDatabase();
    await ScenarioGuide.getScenarioGuidesFromDatabase();
    await RecommendedScenario.getRecommendedScenariosFromDatabase();
    String directoryPath = await getDirectoryPath();
    playersDataFilePath = '$directoryPath/players.json';
    scenariosDataFilePath = '$directoryPath/scenarios.json';
    gameSettingsDataFilePath = '$directoryPath/game_settings.json';
    Player.freePlayers();
    AudioManager.playIntroMusic();
    AudioManager.setPlayerAsset();
  }

  static Future<void> writePlayersData(List<Player> players) async {
    File file = File(playersDataFilePath);
    String jsonString =
        jsonEncode(players.map((player) => player.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  static Future<void> writeScenariosData(List<Scenario> scenarios) async {
    File file = File(scenariosDataFilePath);
    String jsonString =
        jsonEncode(scenarios.map((scenario) => scenario.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  static Future<void> writeGameSettingsData(GameSettings gameSettings) async {
    File file = File(gameSettingsDataFilePath);
    String jsonString = jsonEncode(gameSettings.toJson());
    await file.writeAsString(jsonString);
  }
}
