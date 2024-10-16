import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/Player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';

class DoctorWatson extends Role {
  int selfHeal = 2;

  @override
  void nightAction(Player player) {
    if (player.role!.name == 'دکتر واتسون') {
      selfHeal--;
    }
    GodfatherScenario.nightEvents?[NightEvent.SavedByDoctor] = player;
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.name == 'دکتر واتسون' && selfHeal <= 0) {
        player.playerStatus = PlayerStatus.Disable;
      }
    }
  }
}
