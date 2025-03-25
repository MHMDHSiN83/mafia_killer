import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/database.dart';
import 'package:path_provider/path_provider.dart';

part 'game_settings.g.dart';

@JsonSerializable()
class GameSettings {
  GameSettings() {
    introTime = 30;
    mainSpeakTime = 120;
    inquiry = 2;
    narrator = 'کامبیز دیرباز';
    playMusic = true;
    soundEffect = true;
    narrators = ['کامبیز دیرباز', 'محمدرضا علیمردانی'];
  }

  late int introTime;
  late int mainSpeakTime;
  late int inquiry;
  late String narrator;
  late bool playMusic;
  late bool soundEffect;
  late List<String> narrators;
  static late GameSettings currentGameSettings;
  static late String filePath;

  static Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/game_settings.json';
  }

  static Future<void> getGameSettingsFromDatabase() async {
    filePath = await getFilePath();
    final file = File(filePath);
    if (!(await file.exists())) {
      print('Asset copied to $filePath');
      String jsonString =
          await rootBundle.loadString('lib/assets/game_settings.json');
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      currentGameSettings = GameSettings.fromJson(jsonData);
      await file.writeAsString(jsonString);
    } else {
      print('Game Settings already exists in internal storage');
      String jsonString = await file.readAsString();
      Map<String, dynamic> jsonData;
      try {
        jsonData = jsonDecode(jsonString);
      } catch (e) {
        print('Error reading game settings, loading default settings.');
        String defaultJsonString =
            await rootBundle.loadString('lib/assets/game_settings.json');
        jsonData = jsonDecode(defaultJsonString);
      }
      currentGameSettings = GameSettings.fromJson(jsonData);
    }
  }

  Map<String, dynamic> getSettingsInMap() {
    return {
      'introTime': introTime,
      'mainSpeakTime': mainSpeakTime,
      'inquiry': inquiry,
      'narrator': narrator,
      'playMusic': playMusic,
      'soundEffect': soundEffect,
      'narrators': narrators,
      'scenario': Scenario.currentScenario.name,
    };
  }

  factory GameSettings.fromJson(Map<String, dynamic> json) =>
      _$GameSettingsFromJson(json);

  // Generated method to convert an object to JSON
  Map<String, dynamic> toJson() => _$GameSettingsToJson(this);

  void setNewSettings(Map<String, dynamic> newGameSettings) {
    Scenario.currentScenario =
        Scenario.getScenarioByName(newGameSettings['scenario'])!;
    soundEffect = newGameSettings['soundEffect'];
    introTime = newGameSettings['introTime'];
    mainSpeakTime = newGameSettings['mainSpeakTime'];
    inquiry = newGameSettings['inquiry'];
    narrator = newGameSettings['narrator'];
    playMusic = newGameSettings['playMusic'];
    soundEffect = newGameSettings['soundEffect'];
  }

  static Future<void> updateSettings(
      GameSettings gameSettings, Map<String, dynamic> newGameSettings) async {
    gameSettings.setNewSettings(newGameSettings);
    Database.writeGameSettingsData(currentGameSettings);
  }
}
