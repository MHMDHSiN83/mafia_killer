import 'package:isar/isar.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/scenario.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static late Future<Isar> db;

  IsarService() {
    db = openDB();
    Scenario.getScenariosFromDatabase();
    
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      final isar = await Isar.open(
        [PlayerSchema, GameSettingsSchema, ScenarioSchema],
        inspector: true,
        directory: dir.path,
      );
      int count = await isar.scenarios.count();
      if (count == 0) {
        Scenario.setDefaultScenarios();
      }
      count = await isar.gameSettings.count();
      if (count == 0) {
        GameSettings.setDefaultSettings();
      }
      return isar;
    }
    return Future.value(Isar.getInstance());
  }
}
