import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/Player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';

class Godfather extends Role {

  int remainingAbility = 1;

  @override
  bool hasAbility() {
    return remainingAbility > 0;
  }
  

  @override
  void nightAction(Player player) {
    GodfatherScenario.nightEvents?[NightEvent.SixthSensedByGodfather] = player;
    remainingAbility--;
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.roleSide == RoleSide.mafia) {
        player.playerStatus = PlayerStatus.Disable;
      }
    }
  }
}
