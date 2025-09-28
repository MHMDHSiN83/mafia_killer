import 'dart:convert';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/detective.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/die_hard.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/doctor.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/doctor_lecter.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/joker.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/mayor.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/professional.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/therapist.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/mafia.dart'
    as mafia_nights;
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/citizen.dart'
    as mafia_nights;
import 'package:mafia_killer/models/scenarios/mafia_nights/roles/godfather.dart'
    as mafia_nights;

import 'package:mafia_killer/models/scenarios/godfather/roles/citizen_kane.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/constantine.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/doctor_watson.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/leon.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/matador.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/saul_goodman.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/godfather.dart'
    as godfather;
import 'package:mafia_killer/models/scenarios/godfather/roles/mafia.dart'
    as godfather;
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen.dart'
    as godfather;
import 'package:mafia_killer/pages/intro_night_page.dart';

class Role {
  late String name;
  late String description;
  late String cardImagePath;
  late String characterImagePath;
  late RoleSide roleSide;
  late String slug;

  Role();

  factory Role.copy(Role role) {
    return Role.fromJson(jsonDecode(jsonEncode(role.toJson())));
  }

  static List<Role> copyList(List<Role> roles) {
    return roles.map((role) => Role.copy(role)).toList();
  }

  factory Role.fromJson(Map<String, dynamic> json) {
    switch (json['slug']) {
      case 'godfather.godfather':
        return godfather.Godfather.fromJson(json);
      case 'godfather.saulgoodman':
        return SaulGoodman.fromJson(json);
      case 'godfather.matador':
        return Matador.fromJson(json);
      case 'godfather.mafia':
        return godfather.Mafia.fromJson(json);
      case 'godfather.nostradamus':
        return Nostradamus.fromJson(json);
      case 'godfather.doctor_watson':
        return DoctorWatson.fromJson(json);
      case 'godfather.leon':
        return Leon.fromJson(json);
      case 'godfather.constantine':
        return Constantine.fromJson(json);
      case 'godfather.citizen_kane':
        return CitizenKane.fromJson(json);
      case 'godfather.citizen':
        return godfather.Citizen.fromJson(json);

      case 'mafia_nights.godfather':
        return mafia_nights.Godfather.fromJson(json);
      case 'mafia_nights.doctor_lecter':
        return DoctorLecter.fromJson(json);
      case 'mafia_nights.joker':
        return Joker.fromJson(json);
      case 'mafia_nights.mafia':
        return mafia_nights.Mafia.fromJson(json);
      case 'mafia_nights.doctor':
        return Doctor.fromJson(json);
      case 'mafia_nights.professional':
        return Professional.fromJson(json);
      case 'mafia_nights.mayor':
        return Mayor.fromJson(json);
      case 'mafia_nights.detective':
        return Detective.fromJson(json);
      case 'mafia_nights.therapist':
        return Therapist.fromJson(json);
      case 'mafia_nights.die_hard':
        return DieHard.fromJson(json);
      case 'mafia_nights.citizen':
        return mafia_nights.Citizen.fromJson(json);
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

  String notAnyTargetableText() {
    return '${awakingRole()}(بازیکن هیچکس رو نمی‌تونه انتخاب کنه کمی راه برو و وانمود کن می‌تونه)';
  }

  List<String> roleDetails() {
    return [""];
  }

  Map<String, int> roleAbilities() {
    return {};
  }

  void saveAbilities(Map<String, int> abilities) {}

  bool hasMultiSelection() {
    return false;
  }

  bool hasAllSelected(int number) {
    return number > 0;
  }
}
