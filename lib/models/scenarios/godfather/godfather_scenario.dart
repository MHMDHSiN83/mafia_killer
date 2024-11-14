import 'dart:ffi';

import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/Player_status.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/godfather.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/citizen_kane.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/constantine.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/doctor_watson.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/leon.dart';
import 'package:mafia_killer/pages/night_page.dart';

class GodfatherScenario extends Scenario {
  GodfatherScenario() : super("پدرخوانده");
  static Map<NightEvent, Player?>? nightEvents;

  static Iterable<String> callRolesIntroNight() sync* {
    List<String> awakingTexts = [
      "تیم مافیا بیدار شن و همدیگه رو بشناسن",
      "پدرخوانده لایک بده",
      "ماتادور لایک بده"
    ];
  }

  static Iterable<String> callRolesRegularNight(
    Function mafiaChoiceDialogBox,
    Function confirmAction,
    Function mafiaSixthSenseAct,
    Function mafiaBuyAct,
  ) sync* {
    List<String> mafiaTeamAct = [
      "تیم مافیا به یک نفر شلیک کنه",
      "پدرخوانده کسی که میخواد امشب سلاخی کنه رو نشون بده و نقششو حدس بزنه",
      "ساول گودمن یک نفر رو خریداره کنه"
    ];

    List<String> mafiaTeam = [
      "تیم مافیا از خواب بیدار شه",
      // they should choose one of the three options they have
      "mafia",
      "dalghak"
    ];

    // mafia team action
    yield mafiaTeam[0];
    mafiaChoiceDialogBox();
    yield mafiaTeamAct[NightPage.mafiaTeamChoice];
    switch (NightPage.mafiaTeamChoice) {
      case 0: // shot
        confirmAction();
        nightEvents![NightEvent.ShotByMafia] = NightPage.targetPlayer;
        break;
      case 1: // sixth sense
        Role guessedRole = mafiaSixthSenseAct();
        if (guessedRole.name == NightPage.targetPlayer!.role!.name) {
          nightEvents![NightEvent.SixthSensedByGodfather] =
              NightPage.targetPlayer;
          NightPage.targetPlayer!.hasAbility = false;
        }

        break;
      case 2: // buying
        confirmAction();
        if (NightPage.targetPlayer!.role is Citizen) {
          nightEvents![NightEvent.BoughtBySaulGoodman] = NightPage.targetPlayer;
          mafiaBuyAct(true);
        } else {
          mafiaBuyAct(false);
        }
        break;
    }

    // matador action

    // // handling mafia team
    // for (int i = 0; i < mafiaTeam.length; i++) {
    //   yield mafiaTeam[i];
    // }s

    List<String> citizenRoleOrder = [
      // change the name of this array
      "ماتادور",
      "دکتر واتسون",
      "لئون حرفه‌ای",
      "همشهری کین",
      "کنستانتین",
    ];

    // handling citizen roles
    for (int i = 0; i < citizenRoleOrder.length; i++) {
      for (Player player in Player.inGamePlayers) {
        if (player.hasAbility && (player.role!.name == citizenRoleOrder[i])) {
          print("salam");
          yield player.role!.awakingRole();
          player.role!.nightAction(NightPage.targetPlayer);
          NightPage.targetPlayer = null;
          yield player.role!.sleepRoleText();
          break;
        }
      }
    }
  }

  static String nightReport() {
    String report = "";

    Player? shotByMafia = nightEvents![NightEvent.ShotByMafia];
    Player savedByDoctor = nightEvents![NightEvent.SavedByDoctor]!;
    Player? shotByLeon = nightEvents![NightEvent.ShotByLeon];
    Player? revivedByConstantine =
        nightEvents![NightEvent.RevivedByConstantine];
    Player? inquiryByCitizenKane =
        nightEvents![NightEvent.InquiryByCitizenKane];
    Player? sixthSensedByGodfather =
        nightEvents![NightEvent.SixthSensedByGodfather];

    Player leon = Player.inGamePlayers.whereType<Leon>().first as Player;
    Player citizenKane =
        Player.inGamePlayers.whereType<CitizenKane>().first as Player;
    // mafia shot process -> Done
    if (shotByMafia != null) {
      if (savedByDoctor.name != shotByMafia.name &&
          (shotByMafia is! Leon ||
              (shotByMafia is Leon && (shotByMafia as Leon).shield <= 0)) &&
          shotByMafia is! Nostradamus) {
        shotByMafia.playerStatus = PlayerStatus.DEAD;
        report += "${shotByMafia.name} کشته شد.\n";
      } else if (shotByMafia is Leon && (shotByMafia as Leon).shield == 1) {
        (shotByMafia as Leon).shield--;
      }
    }

    // mafia sixth sense -> Done
    if (sixthSensedByGodfather != null) {
      // if it isn't null it means it succeeded
      report +=
          "${sixthSensedByGodfather.name} سلاخی شد و از بازی به طور کامل خارج میشود\n";
    }

    // leon shot process -> Done
    if (shotByLeon != null) {
      if (shotByLeon.role!.roleSide == RoleSide.citizen) {
        leon.playerStatus = PlayerStatus.DEAD;
      } else if (shotByLeon is! Nostradamus &&
          (shotByLeon is! Godfather ||
              (shotByLeon is Godfather &&
                  (shotByLeon as Godfather).sheild <= 0)) &&
          shotByLeon.name != savedByDoctor.name) {
        shotByLeon.playerStatus = PlayerStatus.DEAD;
        report += "${shotByLeon.name} کشته شد.\n";
      } else if (shotByLeon is Godfather &&
          (shotByLeon as Godfather).sheild == 1) {
        (shotByLeon as Godfather).sheild--;
      }
    }

    // citizen kane inquiry -> player has to die the next day
    if ((citizenKane as CitizenKane).remainingAbility == 0) {
      citizenKane.playerStatus = PlayerStatus.DEAD;
      report += "${citizenKane.name} کشته شد.\n";
    }
    if (inquiryByCitizenKane != null) {
      if (citizenKane.playerStatus == PlayerStatus.ALIVE &&
          inquiryByCitizenKane.playerStatus == PlayerStatus.ALIVE) {
        if (inquiryByCitizenKane.role!.roleSide == RoleSide.mafia) {
          report += "${inquiryByCitizenKane.name} مافیای بازی است\n";
        }
        (citizenKane as CitizenKane).remainingAbility--;
      }
    }

    // constantine reviving
    if (revivedByConstantine != null) {
      revivedByConstantine.playerStatus = PlayerStatus.ALIVE;
      report += "${revivedByConstantine.name} متولد شد.";
    }

    return report;
  }
}
