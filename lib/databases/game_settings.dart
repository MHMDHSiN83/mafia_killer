import 'package:duration/duration.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:mafia_killer/models/isar_service.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/databases/scenario.dart';

part 'game_settings.g.dart';

@collection
class GameSettings {
  GameSettings() {
    scenario.value = Scenario.scenarios[0];
    introTime = '00:30';
    mainSpeakTime = '02:00';
    inquiry = 2;
    narrator = 'کامبیز دیرباز';
    playMusic = true;
    soundEffect = true;
    narrators = ['کامبیز دیرباز', 'محمدرضا علیمردانی'];
  }

  Id id = Isar.autoIncrement;
  var scenario = IsarLink<Scenario>();
  late String introTime;
  late String mainSpeakTime;
  late int inquiry;
  late String narrator;
  late bool playMusic;
  late bool soundEffect;
  late List<String> narrators;

  // String get introTime {
  //   return "0${_introTime.inMinutes}:${_introTime.inSeconds.remainder(60)}";
  // }

  // String get mainSpeakTime {
  //   return "0${_mainSpeakTime.inMinutes}:${_mainSpeakTime.inSeconds.remainder(60)}";
  // }

  Map<String, dynamic> getSettingsInMap() {
    return {
      'scenario': scenario.value!.name,
      'introTime': introTime,
      'mainSpeakTime': mainSpeakTime,
      'inquiry': inquiry.toString(),
      'narrator': narrator,
      'playMusic': playMusic,
      'soundEffect': soundEffect,
      'narrators': narrators,
    };
  }

  void setNewSettings(Map<String, dynamic> newGameSettings) {
    scenario.value = Scenario.getScenarioByName(newGameSettings['scenario']);
    soundEffect = newGameSettings['soundEffect'];
    introTime = newGameSettings['introTime'];
    mainSpeakTime = newGameSettings['mainSpeakTime'];
    inquiry = int.parse(newGameSettings['inquiry']);
    narrator = newGameSettings['narrator'];
    playMusic = newGameSettings['playMusic'];
    soundEffect = newGameSettings['soundEffect'];
  }

  static Future<void> setDefaultSettings() async {
    final GameSettings gameSettings = GameSettings();
    // gameSettings.scenario.value!.roles.loadSync();

    print(gameSettings.scenario.value!.roles.toList());
    final isar = await IsarService.db;
    isar.writeTxnSync(() => isar.gameSettings.putSync(gameSettings));
  }

  static Future<void> updateSettings(
      GameSettings gameSettings, Map<String, dynamic> newGameSettings) async {
    final isar = await IsarService.db;
    isar.writeTxnSync(() {
      gameSettings.setNewSettings(newGameSettings);
      isar.gameSettings.putSync(gameSettings);
    });
  }
}
