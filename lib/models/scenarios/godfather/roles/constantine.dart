import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/Player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';

class Constantine extends Role {
  int remainingAbility = 1;

  Constantine() {
    name = "کنستانتین";
    description =
        "گرداننده کنستانتین را بیدار می‌کند تا او به انتخاب خود و تنها یک بار یک نفر از بازیکنان اخراجی اعم از مافیا، شهروند یا مستقل را به بازی برگرداند. غیر از نقش های افشا شده توانایی های بازیکن احضار شده ادامه پیدا می‌کند و از بین نمی‌رود و از نو نمی‌شود.";
    roleSide = RoleSide.citizen;
    imagePath = "lib/images/roles/constantine.jpg";
  }

  @override
  bool hasAbility() {
    return remainingAbility > 0;
  }

  @override
  void nightAction(Player player) {
    GodfatherScenario.nightEvents?[NightEvent.RevivedByConstantine] = player;
    remainingAbility--;
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.playerStatus != PlayerStatus.Dead) {
        player.playerStatus = PlayerStatus.Disable;
      }
    }
  }

  @override
  String awakingRoleText() {
    return "کنستانتین بیدار شه و یک نفر را به بازی برگردونه";
  }
}
