import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/models/database.dart';
import 'package:mafia_killer/models/scenarios/classic/classic_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/isar_service.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen_kane.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/constantine.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/doctor_watson.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/godfather.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/leon.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/matador.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/saul_goodman.dart';
import 'package:path_provider/path_provider.dart';

part 'scenario.g.dart';

@JsonSerializable()
class Scenario {
  Scenario(this.name);
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('lib/assets/roles.json');
    // print(jsonDecode(response)[name]);
    List<dynamic> decodedList = (jsonDecode(response)[name]);
    // roles = decodedList.map((item) => Role.fromJson(item)).toList();

    roles = [
      Godfather(),
      SaulGoodman(),
      Matador(),
      Nostradamus(),
      DoctorWatson(),
      Leon(),
      Constantine(),
      CitizenKane(),
      Citizen()
    ];
  }

  // Id id = Isar.autoIncrement;
  late final String name;
  late List<Role> roles;
  late List<Role> inGameRoles = [];
  static late Scenario currentScenario;
  static late String filePath;
  factory Scenario.fromJson(Map<String, dynamic> json) =>
      _$ScenarioFromJson(json);

  // Generated method to convert an object to JSON
  Map<String, dynamic> toJson() => _$ScenarioToJson(this);
  // @ignore
  // List<Role> get roles {
  //   List<dynamic> decodedList = jsonDecode(rolesJson);
  //   return decodedList.map((item) => Role.fromJson(item)).toList();
  // }

  // set roles(List<Role> rolesList) {
  //   rolesJson = jsonEncode(rolesList.map((role) => role.toJson()).toList());
  // }

  static List<Scenario> scenarios = [];
  static Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/scenarios.json';
  }

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
    scenarios.add(GodfatherScenario());
    scenarios.add(ClassicScenario());
    await setRoles();
    final isar = await IsarService.db;
    isar.writeTxnSync(() {
      // isar.scenarios.putAllSync(scenarios);
    });
  }

  // static Future<void> getScenariosFromDatabase() async {
  //   final isar = await IsarService.db;
  //   scenarios = isar.scenarios.where().findAllSync();
  // }

  static Future<void> getScenariosFromDatabase() async {
    // final String jsonString =
    //     await rootBundle.loadString('lib/assets/scenarios.json');
    // List<dynamic> decodedList = jsonDecode(jsonString);
    // scenarios.add(Scenario.fromJson(decodedList[0]));
    // scenarios.add(Scenario.fromJson(decodedList[1]));

    filePath = await getFilePath();

    final file = File(filePath);
    if (!(await file.exists())) {
      String jsonString =
          await rootBundle.loadString('lib/assets/scenarios.json');
      List<dynamic> jsonData = jsonDecode(jsonString);
      scenarios = jsonData.map((player) => Scenario.fromJson(player)).toList();
      await file.writeAsString(jsonString);
      print('Asset copied to $filePath');
    } else {
      print('scenario already exists in internal storage');
      String jsonString = await file.readAsString();
      List<dynamic> jsonData = jsonDecode(jsonString);
      scenarios = jsonData.map((player) => Scenario.fromJson(player)).toList();
    }
    currentScenario = scenarios[0];
    // Output the Person's properties
    // print('Name: ${scenarios[0].roles[].awakingRoleText()}');

    // Convert the Person object back to JSON
    // String jsonOutput = jsonEncode(person.toJson());

    // Output the JSON string
    // print('JSON: $jsonOutput');
    // print(jsonDecode(response)[name]);
    // List<dynamic> decodedList = (jsonDecode(response)[name]);
  }

  List<Role> getRolesBySide(RoleSide side) {
    print(roles.whereType<DoctorWatson>().first.awakingRoleText());
    return roles.where((role) => role.roleSide == side).toList();
  }

  // Scenario isCurrentScenario

  // static Future<void> changeRoleCounter(Role newRole) async {
  //   final isar = await IsarService.db;
  //   isar.writeTxnSync(() {
  //     List<Role> tmp = currentScenario.roles;
  //     for (Role role in tmp) {
  //       if (role.name == newRole.name) {
  //         role.counter = newRole.counter;
  //       }
  //     }
  //     currentScenario.roles = tmp;
  //     isar.scenarios.putSync(currentScenario);
  //   });
  // }

  static Future<void> addRole(Role newRole) async {
    // currentScenario.inGameRoles.add(Role.copy(newRole));
    // String roleJson = jsonEncode(newRole.toJson());
    
    currentScenario.inGameRoles.add(Role.fromJson(jsonDecode(jsonEncode(newRole.toJson()))));
    Database.writeScenariosData(scenarios);
    // final isar = await IsarService.db;
    // isar.writeTxnSync(() {
    //   currentScenario.inGameRoles = List.from(currentScenario.inGameRoles);
    //   currentScenario.inGameRoles.add(Role.copy(newRole));
    //   // isar.scenarios.putSync(currentScenario);
    // });
  }

  static Future<void> removeRole(Role role) async {
    for (Role r in currentScenario.inGameRoles) {
      if (r.name == role.name) {
        currentScenario.inGameRoles.remove(r);
        break;
      }
    }
    // final isar = await IsarService.db;
    // isar.writeTxnSync(() {
    //   currentScenario.inGameRoles = List.from(currentScenario.inGameRoles);

    //   for (Role r in currentScenario.inGameRoles) {
    //     if (r.name == role.name) {
    //       currentScenario.inGameRoles.remove(r);
    //       break;
    //     }
    //   }
    //   // isar.scenarios.putSync(currentScenario);
    // });
  }

  // int numberOfRoles() {
  //   int counter = 0;
  //   for (Role role in roles) {
  //     counter += role.counter;
  //   }
  //   return counter;
  // }

  int numberOfRoles(Role role) {
    int counter = 0;
    for (Role r in inGameRoles) {
      if (r.name == role.name) {
        counter++;
      }
    }
    return counter;
  }

  // get a specific role by its name in current scenario
  Role? getRoleByName(String name) {
    return roles.where((role) => role.name == name).firstOrNull;
  }
}
