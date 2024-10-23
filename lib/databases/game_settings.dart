import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/models/isar_service.dart';
import 'package:mafia_killer/databases/scenario.dart';

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

  static Future<void> getGameSettingsFromDatabase() async {
    final String jsonString =
        await rootBundle.loadString('lib/assets/game_settings.json');
    currentGameSettings = (GameSettings.fromJson(jsonDecode(jsonString)));
    // print(jsonDecode(response)[name]);
    // List<dynamic> decodedList = (jsonDecode(response)[name]);
    // roles = decodedList.map((item) => Role.fromJson(item)).toList();
  }

  // static Future<void> getGameSettingsFromDatabase() async {
  //   final isar = await IsarService.db;
  //   currentGameSettings = (await isar.gameSettings.get(1))!;
  //   currentGameSettings.scenario.loadSync();
  //   Scenario.currentScenario = currentGameSettings.scenario.value!;
  // }

  // String get introTime {
  //   return "0${_introTime.inMinutes}:${_introTime.inSeconds.remainder(60)}";
  // }

  // String get mainSpeakTime {
  //   return "0${_mainSpeakTime.inMinutes}:${_mainSpeakTime.inSeconds.remainder(60)}";
  // }

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
    Scenario.currentScenario = Scenario.getScenarioByName(newGameSettings['scenario'])!;
    soundEffect = newGameSettings['soundEffect'];
    introTime = newGameSettings['introTime'];
    mainSpeakTime = newGameSettings['mainSpeakTime'];
    inquiry = newGameSettings['inquiry'];
    narrator = newGameSettings['narrator'];
    playMusic = newGameSettings['playMusic'];
    soundEffect = newGameSettings['soundEffect'];
  }

  static Future<void> setDefaultSettings() async {
    currentGameSettings = GameSettings();
    // gameSettings.scenario.value!.roles.loadSync();
    final isar = await IsarService.db;
    // isar.writeTxnSync(() => isar.gameSettings.putSync(currentGameSettings));
  }

  static Future<void> updateSettings(
      GameSettings gameSettings, Map<String, dynamic> newGameSettings) async {
    final isar = await IsarService.db;
    isar.writeTxnSync(() {
      gameSettings.setNewSettings(newGameSettings);
      // isar.gameSettings.putSync(gameSettings);
    });
  }
}
