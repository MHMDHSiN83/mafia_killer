import 'dart:convert';

import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen_kane.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/constantine.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/doctor_watson.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/godfather.dart' as godfather;
import 'package:mafia_killer/models/scenarios/classic/roles/godfather.dart' as classic;
import 'package:mafia_killer/models/scenarios/godfather/roles/leon.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/mafia.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/matador.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/saul_goodman.dart';
import 'package:mafia_killer/pages/intro_night_page.dart';

class Role {
  late String name;
  late String description;
  late String cardImagePath;
  late String characterImagePath;
  late RoleSide roleSide;

  Role();

  factory Role.copy(Role role) {
    return Role.fromJson(jsonDecode(jsonEncode(role.toJson())));
  }

  static List<Role> copyList(List<Role> roles) {
    return roles.map((role) => Role.copy(role)).toList();
  }
  factory Role.fromJson(Map<String, dynamic> json) {
    switch (json['name']) {
      case 'پدرخوانده':
        return godfather.Godfather.fromJson(json);
      case 'ساول گودمن':
        return SaulGoodman.fromJson(json);
      case 'ماتادور':
        return Matador.fromJson(json);
      case 'مافیا ساده':
        return Mafia.fromJson(json);
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
      default:
        return Role(); 
    }
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

  String introAwakingRole() {
    IntroNightPage.buttonText = 'نشون داد';
    return '$name بیدار شه و لایک نشون بده';
  }

  String introSleepRoleText() {
    IntroNightPage.buttonText = 'خوابید';
    return "$name بخوابه";
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

  List<String> roleDetails() {
    return [""];
  }

  Map<String, int> roleAbilities() {
    return {};
  }

  void saveAbilities(Map<String, int> abilities) {
    
  }

  bool hasMultiSelection() {
    return false;
  }

  bool hasAllSelected(int number) {
    return number > 0;
  }
}
