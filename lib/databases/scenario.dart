import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/recommended_scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/database.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/classic/classic_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/beautiful_mind.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/face_off.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/handcuffs.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/reveal_identity.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/silence_of_the_lambs.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen_kane.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/constantine.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/doctor_watson.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/godfather.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/leon.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/mafia.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/matador.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/saul_goodman.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:path_provider/path_provider.dart';

class Scenario {
  Scenario();

  late String name;
  late List<Role> roles;
  List<LastMoveCard> lastMoveCards = [];
  List<LastMoveCard> inGameLastMoveCards = [];
  List<Role> inGameRoles = [];
  static List<Scenario> scenarios = [];
  static late Scenario currentScenario;
  static late String filePath;
  int nightNumber = 0;
  int dayNumber = 0;
  bool isNight = false;

  Map<NightEvent, Player?> nightEvents = {};
  List<Player> defendingPlayers = [];
  Player? killedInDayPlayer;
  List<Player> silencedPlayerDuringDay = [];
  List<String> report = [];

  factory Scenario.fromJson(Map<String, dynamic> json) {
    switch (json['name']) {
      case 'پدرخوانده':
        return GodfatherScenario.fromJson(json);
      case 'کلاسیک':
        return ClassicScenario.fromJson(json);
      default:
        UnimplementedError('error');
        return Scenario();
    }
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  // Generated method to convert an object to JSON
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

  static Future<void> getScenariosFromDatabase() async {
    filePath = await getFilePath();
    final file = File(filePath);
    if (!(await file.exists())) {
      print('Asset copied to $filePath');
      String jsonString =
          await rootBundle.loadString('lib/assets/scenarios.json');
      List<dynamic> jsonData = jsonDecode(jsonString);
      scenarios =
          jsonData.map((scenario) => Scenario.fromJson(scenario)).toList();
      await file.writeAsString(jsonString);
    } else {
      print('scenario already exists in internal storage');
      List<dynamic> jsonData;
      try {
        String jsonString = await file.readAsString();
        jsonData = jsonDecode(jsonString);
      } catch (e) {
        String jsonString =
            await rootBundle.loadString('lib/assets/scenarios.json');
        jsonData = jsonDecode(jsonString);
      }
      scenarios = jsonData.map((player) => Scenario.fromJson(player)).toList();
    }
    currentScenario = scenarios[0];
  }

  List<Role> getRolesBySide(RoleSide side) {
    return roles.where((role) => role.roleSide == side).toList();
  }

  int getNumberOfRoleBySide(RoleSide side) {
    return inGameRoles.where((role) => role.roleSide == side).toList().length;
  }

  static Future<void> addRole(Role? newRole) async {
    if (newRole == null) {
      return;
    }
    currentScenario.inGameRoles.add(Role.copy(newRole));
    Database.writeScenariosData(scenarios);
  }

  static Future<void> removeRole(Role role) async {
    for (Role r in currentScenario.inGameRoles) {
      if (r.name == role.name) {
        currentScenario.inGameRoles.remove(r);
        break;
      }
    }
    Database.writeScenariosData(scenarios);
  }

  static Future<void> addLastMoveCard(LastMoveCard? newLastMoveCard) async {
    if (newLastMoveCard == null) {
      return;
    }
    currentScenario.inGameLastMoveCards.add(LastMoveCard.fromJson(
        jsonDecode(jsonEncode(newLastMoveCard.toJson()))));
    Database.writeScenariosData(scenarios);
  }

  static Future<void> removeLastMoveCard(LastMoveCard lastMoveCard) async {
    for (LastMoveCard l in currentScenario.inGameLastMoveCards) {
      if (l.title == lastMoveCard.title) {
        currentScenario.inGameLastMoveCards.remove(l);
        break;
      }
    }
    Database.writeScenariosData(scenarios);
  }

  int numberOfRoles(Role role) {
    int counter = 0;
    for (Role r in inGameRoles) {
      if (r.name == role.name) {
        counter++;
      }
    }
    return counter;
  }

  int numberOfLastMoveCards(LastMoveCard lastMoveCard) {
    int counter = 0;
    for (LastMoveCard l in inGameLastMoveCards) {
      if (l.title == lastMoveCard.title) {
        counter++;
      }
    }
    return counter;
  }

  // get a specific role by its name in current scenario
  Role? getRoleByName(String name) {
    return roles.where((role) => role.name == name).firstOrNull;
  }

  List<String> getConstantRoleOrder() {
    List<String> constantRoleOrder = [];
    for (Role role in inGameRoles) {
      if (role is Matador) {
        constantRoleOrder.add("ماتادور");
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is DoctorWatson) {
        constantRoleOrder.add("دکتر واتسون");
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Leon) {
        constantRoleOrder.add("لئون حرفه‌ای");
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is CitizenKane) {
        constantRoleOrder.add("همشهری کین");
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Constantine) {
        constantRoleOrder.add("کنستانتین");
        break;
      }
    }
    return constantRoleOrder;
  }

  List<String> getIntroMafiaTeamAwakingTexts() {
    List<String> introMafiaTeamAwakingTexts = [
      "تیم مافیا بیدار شن و همدیگه رو بشناسن",
    ];
    Role? godfather = getRoleByType(Godfather);
    Role? matador = getRoleByType(Matador);
    Role? saulGoodman = getRoleByType(SaulGoodman);
    Role? theMafia = getRoleByType(Mafia);
    if (godfather != null) {
      introMafiaTeamAwakingTexts.add(godfather.introAwakingRole());
    }
    if (matador != null) {
      introMafiaTeamAwakingTexts.add(matador.introAwakingRole());
    }
    if (saulGoodman != null) {
      introMafiaTeamAwakingTexts.add(saulGoodman.introAwakingRole());
    }
    if (theMafia != null) {
      introMafiaTeamAwakingTexts.add(theMafia.introAwakingRole());
    }
    introMafiaTeamAwakingTexts.add("تیم مافیا بخوابه");
    return introMafiaTeamAwakingTexts;
  }

  List<Role> getIntroCitizenTeamRoles() {
    List<Role> citizenRoles = [];
    for (Role role in inGameRoles) {
      if (role is DoctorWatson) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Leon) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is CitizenKane) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Constantine) {
        citizenRoles.add(role);
        break;
      }
    }
    return citizenRoles;
  }

  Role? getRoleByType(Type type, {searchInGmaeRoles = true}) {
    if (searchInGmaeRoles) {
      for (Role role in inGameRoles) {
        if (role.runtimeType == type) {
          return role;
        }
      }
      return null;
    } else {
      for (Role role in roles) {
        if (role.runtimeType == type) {
          return role;
        }
      }
      return null;
    }
  }

  LastMoveCard? getLastMoveCardByType(Type type) {
    for (LastMoveCard lastMoveCard in lastMoveCards) {
      if (lastMoveCard.runtimeType == type) {
        return lastMoveCard;
      }
    }
    return null;
  }

  String dayAndNightNumber({int? number}) {
    number ??= isNight ? nightNumber : dayNumber;
    switch (number) {
      case 0:
        return 'معارفه';
      case 1:
        return 'اول';
      case 2:
        return 'دوم';
      case 3:
        return 'سوم';
      case 4:
        return 'چهارم';
      case 5:
        return 'پنجم';
      case 6:
        return 'ششم';
      case 7:
        return 'هفتم';
      case 8:
        return 'هشتم';
      case 9:
        return 'نهم';
      case 10:
        return 'دهم';
      default:
        return 'not enough';
    }
  }

  void goToNextStage() {
    if (isNight) {
      nightNumber++;
    } else {
      dayNumber++;
    }
    isNight = !isNight;
  }

  void backToLastStage() {
    if (isNight) {
      dayNumber--;
    } else {
      nightNumber--;
    }
    isNight = !isNight;
  }

  void resetDayes() {
    dayNumber = 0;
    nightNumber = 0;
    isNight = false;
  }

  bool isIntroDay() {
    return dayNumber == 0;
  }

  Iterable<String> callRolesIntroNight() sync* {}

  void resetRemainingAbility() {}

  void resetUIPlayerStatus() {
    for (Player player in Player.inGamePlayers) {
      if (player.playerStatus == PlayerStatus.active ||
          player.playerStatus == PlayerStatus.disable) {
        player.uiPlayerStatus = UIPlayerStatus.targetable;
      } else {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  void setPlayersToUntargetable() {
    for (Player player in Player.inGamePlayers) {
      player.uiPlayerStatus = UIPlayerStatus.untargetable;
    }
  }

  void setMafiaTeamAvailablePlayers() {}

  Iterable<String> mafiaTeamAction({Function? mafiaChoiceBox}) sync* {}

  Iterable<String> otherRolesAction({Function? noAbilityBox}) sync* {}

  Iterable<String> callRolesRegularNight(
      {Function? mafiaChoiceBox, Function? noAbilityBox}) sync* {}

  void nightReport() {}

  bool isGameOver() {
    throw UnimplementedError();
  }

  RoleSide whichTeamWon() {
    throw UnimplementedError();
  }

  void storeDefendingPlayers(List<Player> players) {
    defendingPlayers = players;
  }

  void resetDataAfterNight() {
    nightEvents = {};
    defendingPlayers = [];
    killedInDayPlayer = null;
    report = [];

    for (Player player in Player.inGamePlayers) {
      if (player.playerStatus == PlayerStatus.disable) {
        player.playerStatus = PlayerStatus.active;
      }
    }
  }

  int numberOfDeadPlayersBySide(RoleSide roleSide) {
    int counter = 0;
    for (Player player in Player.inGamePlayers) {
      if ((player.playerStatus == PlayerStatus.dead ||
              player.playerStatus == PlayerStatus.removed) &&
          player.role!.roleSide == roleSide) {
        counter++;
      }
    }
    return counter;
  }

  void getRecommendedScenario() {
    inGameRoles = [];
    inGameLastMoveCards = [];
    Map<String, int>? recommendedScenario =
        RecommendedScenario.getRecommendedScenario();
    recommendedScenario ??= RecommendedScenario.generateRecommendedScenario();
    recommendedScenario.forEach((key, value) {
      Role? role;
      LastMoveCard? lastMoveCard;
      switch (key) {
        case 'godfather':
          role = getRoleByType(Godfather, searchInGmaeRoles: false)!;
          break;
        case 'saul_goodman':
          role = getRoleByType(SaulGoodman, searchInGmaeRoles: false)!;
          break;
        case 'matador':
          role = getRoleByType(Matador, searchInGmaeRoles: false)!;
          break;
        case 'mafia':
          role = getRoleByType(Mafia, searchInGmaeRoles: false)!;
          break;
        case 'nostradamus':
          role = getRoleByType(Nostradamus, searchInGmaeRoles: false)!;
          break;
        case 'doctor_watson':
          role = getRoleByType(DoctorWatson, searchInGmaeRoles: false)!;
          break;
        case 'leon':
          role = getRoleByType(Leon, searchInGmaeRoles: false)!;
          break;
        case 'citizen_kane':
          role = getRoleByType(CitizenKane, searchInGmaeRoles: false)!;
          break;
        case 'constantine':
          role = getRoleByType(Constantine, searchInGmaeRoles: false)!;
          break;
        case 'citizen':
          role = getRoleByType(Citizen, searchInGmaeRoles: false)!;
          break;
        case 'beautiful_mind':
          lastMoveCard = getLastMoveCardByType(BeautifulMind);
          break;
        case 'face_off':
          lastMoveCard = getLastMoveCardByType(FaceOff);
          break;
        case 'handcuffs':
          lastMoveCard = getLastMoveCardByType(Handcuffs);
          break;
        case 'reveal_identity':
          lastMoveCard = getLastMoveCardByType(RevealIdentity);
          break;
        case 'silence_of_the_lambs':
          lastMoveCard = getLastMoveCardByType(SilenceOfTheLambs);
          break;
      }
      for (int i = 0; i < value; i++) {
        addRole(role);
      }
      for (int i = 0; i < value; i++) {
        addLastMoveCard(lastMoveCard);
      }
    });
  }

  // TODO: this should be removed
  void resetScenarioDataBeforeGame() {
    nightEvents = {};
    defendingPlayers = [];
    killedInDayPlayer = null;
    silencedPlayerDuringDay = [];
    report = [];
  }
}
