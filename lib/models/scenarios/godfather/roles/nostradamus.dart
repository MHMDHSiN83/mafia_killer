import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/Player_status.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
class Nostradamus extends Role {
  int introNightAction(List<Player> players) {
    int result = 0;
    for (Player player in players) {
      if(player.role!.roleSide == RoleSide.mafia && player.role!.name != 'پدرخوانده') {
        result++;
      }
    }
    return result;
  }
  
  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.name == 'نوستراداموس') {
        player.playerStatus = PlayerStatus.Disable;
      }
    }
  }
}
