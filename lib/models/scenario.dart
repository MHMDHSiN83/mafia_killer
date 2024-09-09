import 'package:isar/isar.dart';
import 'package:mafia_killer/models/isar_service.dart';

part 'scenario.g.dart';

@Collection()
class Scenario {
  Id id = Isar.autoIncrement;
  Scenario(this.name);
  late final String name;
  static List<Scenario> scenarios = [];

  static List<String> getScenarioNames() {
    List<String> result = [];
    for (Scenario scenario in scenarios) {
      result.add(scenario.name);
    }
    return result;
  }

  static Scenario? getScenarioByName(String name) {
    for (Scenario scenario in scenarios) {
      if (scenario.name == name) {
        return scenario;
      }
    }
    return null;
  }

  static void setDefaultScenarios() async {
    scenarios.add(Scenario('پدرخوانده'));
    scenarios.add(Scenario('کلاسیک'));
    final isar = await IsarService.db;
  
    isar.writeTxnSync(() => isar.scenarios.putAllSync(scenarios));
  }
  static void getScenariosFromDatabase() async {
    final isar = await IsarService.db;
    scenarios = isar.scenarios.where().findAllSync();
  }
}
