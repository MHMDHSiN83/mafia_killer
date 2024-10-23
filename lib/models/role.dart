import 'package:isar/isar.dart';
import 'package:mafia_killer/databases/player.dart';
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

part 'role.g.dart';

@embedded
class Role {
  late String name;
  late String description;
  late String imagePath;
  @Enumerated(EnumType.ordinal32)
  late RoleSide roleSide;

  Role();
  factory Role.copy(Role role) {
    Role newRole = Role();
    newRole.name = role.name;
    newRole.description = role.description;
    newRole.imagePath = role.imagePath;
    newRole.roleSide = role.roleSide;
    return newRole;
  }
  // factory Scenario.fromJson(Map<String, dynamic> json) =>
  //     _$ScenarioFromJson(json);

  // // Generated method to convert an object to JSON
  // Map<String, dynamic> toJson() => _$ScenarioToJson(this);
  factory Role.fromJson(Map<String, dynamic> json) {
    switch (json['name']) {
      case 'پدرخوانده':
        return Godfather.fromJson(json);
      case 'ساول گودمن':
        print(json);
        return SaulGoodman.fromJson(json);
      case 'ماتادور':
        return Matador.fromJson(json);
      case 'نوستراداموس':
        return Nostradamus.fromJson(json);
      case 'دکتر واتسون':
        return DoctorWatson.fromJson(json);
      case 'لئون حرفه‌ای':
        return Leon.fromJson(json);
      case 'کنستانتین':
        return Constantine.fromJson(json);
      case 'همشهری کین':
        return CitizenKane.fromJson(json);
      case 'شهروند ساده':
        return Citizen.fromJson(json);
    }

    if (json['name'] == 'دکتر واتسون') {
      return DoctorWatson.fromJson(json);
    }
    Role role = Role();
    role.name = json['name'];
    role.description = json['description'];
    role.roleSide = RoleSide.values
        .firstWhere((e) => e.toString().split('.').last == json['roleSide']);
    role.imagePath = json['imagePath'];
    return role;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'roleSide': roleSide.toString().split('.').last,
      'imagePath': imagePath,
    };
  }

  void nightAction(Player player) {}

  void setAvailablePlayers() {
    throw UnimplementedError("Mafia Kos");
  }

  bool hasAbility() {
    return true;
  }

  String awakingRoleText() {
    throw UnimplementedError(name);
  }

  String sleepRoleText() {
    return "$name بخوابه";
  }
}
