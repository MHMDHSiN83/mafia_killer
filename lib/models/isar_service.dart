import 'package:isar/isar.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static late Future<Isar> db;

  IsarService() {
    db = openDB();
    setInitialValues();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      final isar = await Isar.open(
        [PlayerSchema, GameSettingsSchema, ScenarioSchema],
        inspector: true,
        directory: dir.path,
      );
      return isar;
    }
    return Future.value(Isar.getInstance());
  }

  void setInitialValues() async {
    final isar = await IsarService.db;
    await Player.freePlayers();
    int count = await isar.scenarios.count();
    if (count == 0) {
      await Scenario.setDefaultScenarios();
    } else {
      await Scenario.getScenariosFromDatabase();
    }
    count = await isar.gameSettings.count();
    if (count == 0) {
      await GameSettings.setDefaultSettings();
    } else {
      await GameSettings.getGameSettingsFromDatabase();
    }
  }
}
