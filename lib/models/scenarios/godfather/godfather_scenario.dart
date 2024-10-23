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

class GodfatherScenario extends Scenario {
  GodfatherScenario() : super("پدرخوانده");
  static Map<NightEvent, Player>? nightEvents;

  static Iterable<String> callRolesIntroNight() sync* {}
  static Iterable<String> callRolesRegularNight() sync* {
    // List<String> mafiaTeam = [
    //   "تیم مافیا از خواب بیدار شه",
    //   // they should choose one of the three options they have
    //   "ماتادور توانایی یک نفر را در شب ازش بگیره",
    //   "مافیا ها بخوابن",
    //   "mafia",
    //   "dalghak"
    // ];

    // // handling mafia team
    // for (int i = 0; i < mafiaTeam.length; i++) {
    //   yield mafiaTeam[i];
    // }

    List<String> roleOrder = [
      "دکتر واتسون",
      "لئون حرفه‌ای",
      "همشهری کین",
      "کنستانتین",
    ];

    // handling citizen roles
    for (int i = 0; i < roleOrder.length; i++) {
      for (Player player in Player.inGamePlayers) {
        if (player.playerStatus == PlayerStatus.Active &&
            (player.role!.name == roleOrder[i])) {
          print("salam");
          yield player.role!.awakingRoleText();
          yield player.role!.sleepRoleText();
          break;
        }
      }
    }
  }
}
