import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/models/isar_service.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';

part 'scenario.g.dart';

@Collection()
class Scenario {
  Scenario(this.name);
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('lib/assets/roles.json');
    // print(jsonDecode(response)[name]);
    List<dynamic> decodedList = (jsonDecode(response)[name]);
    roles = decodedList.map((item) => Role.fromJson(item)).toList();
  }

  Id id = Isar.autoIncrement;
  late final String name;
  late List<Role> roles;
  static late Scenario currentScenario;

  // @ignore
  // List<Role> get roles {
  //   List<dynamic> decodedList = jsonDecode(rolesJson);
  //   return decodedList.map((item) => Role.fromJson(item)).toList();
  // }

  // set roles(List<Role> rolesList) {
  //   rolesJson = jsonEncode(rolesList.map((role) => role.toJson()).toList());
  // }

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

  static Future<void> setRoles() async {
    for (Scenario scenario in scenarios) {
      await scenario.readJson();
    }
  }

  static Future<void> setDefaultScenarios() async {
    scenarios.add(Scenario('پدرخوانده'));
    scenarios.add(Scenario('کلاسیک'));
    await setRoles();
    final isar = await IsarService.db;
    isar.writeTxnSync(() {
      isar.scenarios.putAllSync(scenarios);
    });
  }

  static Future<void> getScenariosFromDatabase() async {
    final isar = await IsarService.db;
    scenarios = isar.scenarios.where().findAllSync();
  }

  List<Role> getRolesBySide(RoleSide side) {
    return roles.where((role) => role.roleSide == side).toList();
  }

  // Scenario isCurrentScenario

  static Future<void> changeRoleCounter(Role newRole) async {
    final isar = await IsarService.db;
    isar.writeTxnSync(() {
      List<Role> tmp = currentScenario.roles;
      for (Role role in tmp) {
        if (role.name == newRole.name) {
          role.counter = newRole.counter;
        }
      }
      currentScenario.roles = tmp;
      isar.scenarios.putSync(currentScenario);
    });
  }

  int numberOfRoles() {
    int counter = 0;
    for (Role role in roles) {
      counter += role.counter;
    }
    return counter;
  }
}
