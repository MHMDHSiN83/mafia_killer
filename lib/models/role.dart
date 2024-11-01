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

class Role {
  late String name;
  late String description;
  late String cardImagePath;
  late String characterImagePath;
  // @Enumerated(EnumType.ordinal32)
  late RoleSide roleSide;

  Role();
  factory Role.copy(Role role) {
    Role newRole = Role();
    newRole.name = role.name;
    newRole.description = role.description;
    newRole.cardImagePath = role.cardImagePath;
    newRole.characterImagePath = role.characterImagePath;
    newRole.roleSide = role.roleSide;
    return newRole;
  }

  factory Role.fromJson(Map<String, dynamic> json) {
    switch (json['name']) {
      case 'پدرخوانده':
        return Godfather.fromJson(json);
      case 'ساول گودمن':
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
    role.cardImagePath = json['cardImagePath'];
    role.characterImagePath = json['characterImagePath'];
    return role;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'roleSide': roleSide.toString().split('.').last,
      'cardImagePath': cardImagePath,
      'characterImagePath': characterImagePath,
    };
  }

  void nightAction(Player? player) {}

  void setAvailablePlayers() {
    throw UnimplementedError("Mafia Kos");
  }

  String awakingRole() {
    throw UnimplementedError(name);
  }

  String sleepRoleText() {
    return "$name بخوابه";
  }

  bool hasAbility() {
    return true;
  }

  String disabledText() {
    return '${awakingRole()}(به بازیکن نشون بده که تواناییش ازش گرفته شده)';
  }

  String ranOutOfAbilityText() {
    return '${awakingRole()}(به بازیکن نشون بده که تواناییش تموم شده)';
  }

  String deadOrRemovedText() {
    return '${awakingRole()}(بازیکن از بازی خارج شده کمی راه برو و وانمود کن نقش هنوز تو بازیه)';
  }
}
