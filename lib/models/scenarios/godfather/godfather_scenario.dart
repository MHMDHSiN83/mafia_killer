import 'dart:ffi';

import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
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
  static Map<NightEvent, Player>? nightEvents;

  static Iterable<String> callRolesIntroNight(String text) sync* {
    for (int i = 0; i < 2; i++) {
      yield text;
    }
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
        if (guessedRole.name == NightPage.targetPlayer.role!.name) {
          nightEvents![NightEvent.SixthSensedByGodfather] =
              NightPage.targetPlayer;
          NightPage.targetPlayer.hasAbility = false;
        }

        break;
      case 2: // buying
        confirmAction();
        if (NightPage.targetPlayer.role is Citizen) {
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
    // }

    List<String> citizenRoleOrder = [
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
          yield player.role!.sleepRoleText();
          break;
        }
      }
    }
  }
}
