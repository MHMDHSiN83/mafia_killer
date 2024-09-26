import 'package:isar/isar.dart';
import 'package:mafia_killer/models/isar_service.dart';
import 'package:mafia_killer/databases/scenario.dart';

part 'game_settings.g.dart';

@collection
class GameSettings {
  GameSettings() {
    scenario.value = Scenario.scenarios[0];
    introTime = 30;
    mainSpeakTime = 120;
    inquiry = 2;
    narrator = 'کامبیز دیرباز';
    playMusic = true;
    soundEffect = true;
    narrators = ['کامبیز دیرباز', 'محمدرضا علیمردانی'];
  }

  Id id = Isar.autoIncrement;
  var scenario = IsarLink<Scenario>();
  late int introTime;
  late int mainSpeakTime;
  late int inquiry;
  late String narrator;
  late bool playMusic;
  late bool soundEffect;
  late List<String> narrators;
  static late GameSettings currentGameSettings; 


  static Future<void> getGameSettingsFromDatabase() async{
    final isar = await IsarService.db;
    currentGameSettings = (await isar.gameSettings.get(1))!;
    currentGameSettings.scenario.loadSync();
    Scenario.currentScenario = currentGameSettings.scenario.value!;
  }
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
      'inquiry': inquiry,
      'narrator': narrator,
      'playMusic': playMusic,
      'soundEffect': soundEffect,
      'narrators': narrators,
    };
  }

  void setNewSettings(Map<String, dynamic> newGameSettings) {
    scenario.value = Scenario.getScenarioByName(newGameSettings['scenario']);
    Scenario.currentScenario = scenario.value!;
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
    isar.writeTxnSync(() => isar.gameSettings.putSync(currentGameSettings));
    Scenario.currentScenario = currentGameSettings.scenario.value!;
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
