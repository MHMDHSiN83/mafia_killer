import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/detective.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/die_hard.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/doctor.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/doctor_lecter.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/godfather.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/joker.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/mafia.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/mayor.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/professional.dart';
import 'package:mafia_killer/models/scenarios/classic/roles/therapist.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/pages/intro_night_page.dart';
import 'package:mafia_killer/pages/night_page.dart';

part 'classic_scenario.g.dart';

@JsonSerializable()
class ClassicScenario extends Scenario {
  ClassicScenario() : super();

  factory ClassicScenario.fromJson(Map<String, dynamic> json) =>
      _$ClassicScenarioFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClassicScenarioToJson(this);

  @override
  String validateConditions() {
    String error = super.validateConditions();

    if (error != '') {
      return error;
    }

    int mafiaCount = getNumberOfRoleBySide(RoleSide.mafia);
    int citizenCount = getNumberOfRoleBySide(RoleSide.citizen);

    if (citizenCount <= mafiaCount) {
      error = 'تعداد مافیاها باید از شهروندها کمتر باشه';
      return error;
    }

    return error;
  }

  @override
  Iterable<String> callRolesIntroNight({Function? independantBox}) sync* {
    ableToSelectTile = false;
    currentPlayerAtNight = Player.inGamePlayers.first;
    resetUIPlayerStatus();

    List<String> introMafiaTeamAwakingTexts = getIntroMafiaTeamAwakingTexts();
    List<Role> introCitizenTeamRoles = getIntroCitizenTeamRoles();
    IntroNightPage.buttonText = 'بیدار شدند';

    int l = introMafiaTeamAwakingTexts.length;
    for (int i = 0; i < l; i++) {
      yield introMafiaTeamAwakingTexts[i];
      if (i == l - 2) {
        IntroNightPage.buttonText = 'خوابیدند';
      } else {
        IntroNightPage.buttonText = 'نشون داد';
      }
    }
    for (int i = 0; i < introCitizenTeamRoles.length; i++) {
      yield introCitizenTeamRoles[i].introAwakingRole();
      yield introCitizenTeamRoles[i].introSleepRoleText();
    }
    IntroNightPage.isNightOver = true;
    IntroNightPage.buttonText = "";
    yield "همه بیدار شن";
  }

  @override
  List<String> getIntroMafiaTeamAwakingTexts() {
    List<String> introMafiaTeamAwakingTexts = [
      "تیم مافیا بیدار شن و همدیگه رو بشناسن",
    ];
    Role? godfather = getRoleByType(Godfather);
    Role? matador = getRoleByType(DoctorLecter);
    Role? saulGoodman = getRoleByType(Joker);
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

  @override
  List<Role> getIntroCitizenTeamRoles() {
    List<Role> citizenRoles = [];
    for (Role role in inGameRoles) {
      if (role is Doctor) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Detective) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Mayor) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is DieHard) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Professional) {
        citizenRoles.add(role);
        break;
      }
    }
    for (Role role in inGameRoles) {
      if (role is Therapist) {
        citizenRoles.add(role);
        break;
      }
    }
    return citizenRoles;
  }

  @override
  void setMafiaTeamAvailablePlayers() {
    resetUIPlayerStatus();
    for (Player player in Player.inGamePlayers) {
      if (player.role! is Godfather) {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  Iterable<String> mafiaTeamAction({Function? mafiaChoiceBox}) sync* {
    yield "تیم مافیا از خواب بیدار شه";
    ableToSelectTile = true;
    NightPage.buttonText = '';
    yield "تیم مافیا از خواب بیدار شه";
    yield 'تیم مافیا به یکی شلیک کنه'; // TODO: probable move to godfather role(?)
    ableToSelectTile = true;

    List<String> constantRoleOrder = getMafiaRoleOrder();

    for (int i = 0; i < constantRoleOrder.length; i++) {
      Player? player = Player.getPlayerByRoleName(constantRoleOrder[i]);
      if (player == null) {
        continue;
      }
      ableToSelectTile = true;
      resetUIPlayerStatus();
      NightPage.buttonText = '';
      currentPlayerAtNight = player;
      player.role!.setAvailablePlayers();
      yield player.role!.awakingRole();
      player.role!.nightAction(NightPage.targetPlayers[0]);
      ableToSelectTile = false;
      // NightPage.buttonText = "خوابید";
      // yield player.role!.sleepRoleText();
    }
    NightPage.buttonText = 'خوابید';
    ableToSelectTile = false;
    yield 'تیم مافیا بخوابه';
  }

  @override
  List<String> getMafiaRoleOrder() {
    List<String> constantRoleOrder = ['دکتر لکتر', 'جوکر'];
    return constantRoleOrder;
  }

  @override
  List<String> getOtherRoleOrder() {
    List<String> constantRoleOrder = [
      'ماتادور',
      'دکتر واتسون',
      'لئون حرفه‌ای',
      'همشهری کین',
      'کنستانتین'
    ];
    return constantRoleOrder;
  }

  @override
  Iterable<String> otherRolesAction({Function? noAbilityBox}) sync* {
    List<String> constantRoleOrder = getOtherRoleOrder();
    NightPage.buttonText = 'خوابید';

    for (int i = 0; i < constantRoleOrder.length; i++) {
      Player? player = Player.getPlayerByRoleName(constantRoleOrder[i]);
      if (player == null) {
        continue;
      }

      ableToSelectTile = true;
      resetUIPlayerStatus();
      if (player.hasAbility()) {
        NightPage.buttonText = i <= 1 ? '' : "هیچکس";
        currentPlayerAtNight = player;
        player.role!.setAvailablePlayers();
        if (player.role!.hasMultiSelection()) {
          NightPage.buttonText = "تائید";
        }
        yield player.role!.awakingRole();
        for (Player p in NightPage.targetPlayers) {
          player.role!.nightAction(p);
        }
        ableToSelectTile = false;
        NightPage.buttonText = "خوابید";
        yield player.role!.sleepRoleText();
      } else {
        setPlayersToUntargetable();
        if (player.playerStatus == PlayerStatus.disable) {
          noAbilityBox!(player.role!.disabledText());
        } else if (!player.role!.hasAbility()) {
          noAbilityBox!(player.role!.ranOutOfAbilityText());
        } else {
          noAbilityBox!(player.role!.deadOrRemovedText());
        }
        yield player.role!.sleepRoleText();
      }
    }
  }

  @override
  Iterable<String> callRolesRegularNight(
      {Function? mafiaChoiceBox, Function? noAbilityBox}) sync* {
    Scenario.currentScenario.currentPlayerAtNight = Player.inGamePlayers.first;
    final iterator = mafiaTeamAction(mafiaChoiceBox: mafiaChoiceBox!).iterator;

    while (iterator.moveNext()) {
      yield iterator.current;
    }

    final otherRolesIterator =
        otherRolesAction(noAbilityBox: noAbilityBox!).iterator;

    while (otherRolesIterator.moveNext()) {
      yield otherRolesIterator.current;
    }
    NightPage.isNightOver = true;
    NightPage.buttonText = "";
    yield "همه بیدار شن";
    nightReport();
  }

  // @override
  // void nightReport() {
  //   Player? shotByMafia = getFirstPlayer(NightEvent.shotByMafia);
  //   Player? shotByLeon = getFirstPlayer(NightEvent.shotByLeon);
  //   Player? revivedByConstantine =
  //       getFirstPlayer(NightEvent.revivedByConstantine);
  //   Player? inquiryByCitizenKane =
  //       getFirstPlayer(NightEvent.inquiryByCitizenKane);
  //   Player? sixthSensedByGodfather =
  //       getFirstPlayer(NightEvent.sixthSensedByGodfather);

  //   List<Player> savedByDoctor = nightEvents[NightEvent.savedByDoctor] ?? [];

  //   Player? leon = Player.getPlayerByRoleType(Leon);
  //   Player? citizenKane = Player.getPlayerByRoleType(CitizenKane);

  //   // mafia shot process -> Done
  //   if (shotByMafia != null) {
  //     bool isSaved = savedByDoctor.any((p) => p.name == shotByMafia.name);

  //     if (!isSaved &&
  //         (shotByMafia.role is! Leon ||
  //             (shotByMafia.role is Leon &&
  //                 (shotByMafia.role as Leon).shield <= 0)) &&
  //         (shotByMafia.role is! Nostradamus ||
  //             (shotByMafia.role is Nostradamus &&
  //                 !(shotByMafia.role as Nostradamus).shield))) {
  //       shotByMafia.playerStatus = PlayerStatus.dead;
  //       report.add("${shotByMafia.name} کشته شد.");
  //     } else if (shotByMafia.role is Leon &&
  //         (shotByMafia.role as Leon).shield == 1) {
  //       (shotByMafia.role as Leon).shield--;
  //     }
  //   }
  //   // mafia sixth sense -> Done
  //   if (sixthSensedByGodfather != null) {
  //     // if it isn't null it means it succeeded
  //     sixthSensedByGodfather.playerStatus = PlayerStatus.removed;
  //     report.add(
  //         "${sixthSensedByGodfather.name} سلاخی شد و از بازی به طور کامل خارج میشود");
  //   }

  //   // leon shot process -> Done
  //   if (shotByLeon != null) {
  //     bool isSaved = savedByDoctor.any((p) => p.name == shotByLeon.name);
  //     if (shotByLeon.role!.roleSide == RoleSide.citizen) {
  //       leon!.playerStatus = PlayerStatus.dead;
  //       report.add("${leon.name} کشته شد.");
  //     } else if (shotByLeon.role is! Nostradamus &&
  //         (shotByLeon.role is! Godfather ||
  //             (shotByLeon.role is Godfather &&
  //                 (shotByLeon.role as Godfather).shield <= 0)) &&
  //         !isSaved) {
  //       shotByLeon.playerStatus = PlayerStatus.dead;
  //       report.add("${shotByLeon.name} کشته شد.");
  //     } else if (shotByLeon.role is Godfather &&
  //         (shotByLeon.role as Godfather).shield == 1) {
  //       (shotByLeon.role as Godfather).shield--;
  //     }
  //   }

  //   // citizen kane inquiry -> player has to die the next day
  //   if ((citizenKane != null) &&
  //       (citizenKane.role as CitizenKane).remainingAbility == 0) {
  //     citizenKane.playerStatus = PlayerStatus.dead;
  //     report.add("${citizenKane.name} کشته شد.");
  //   }
  //   if (inquiryByCitizenKane != null) {
  //     if (citizenKane!.playerStatus == PlayerStatus.active &&
  //         inquiryByCitizenKane.playerStatus == PlayerStatus.active) {
  //       if (inquiryByCitizenKane.role!.roleSide == RoleSide.mafia) {
  //         report.add("${inquiryByCitizenKane.name} مافیای بازی است");
  //       }
  //       (citizenKane.role as CitizenKane).remainingAbility--;
  //     }
  //   }
  //   // constantine reviving
  //   if (revivedByConstantine != null) {
  //     revivedByConstantine.playerStatus = PlayerStatus.active;
  //     report.add("${revivedByConstantine.name} متولد شد.");
  //   }

  //   if (report.isEmpty) {
  //     report.add("توی شبی که گذشت هیچکس کشته نشد!");
  //   }
  // }
}
