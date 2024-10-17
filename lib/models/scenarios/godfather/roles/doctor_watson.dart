import 'package:isar/isar.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/Player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';

class DoctorWatson extends Role {
  int selfHeal = 2;

  DoctorWatson() {
    name = "دکتر واتسون";
    description =
        "هر شب می‌تواند جان یک نفر چه عضو مافیا و چه عضو شهروندی را نجات دهد. جان خودش را یکبار می‌تواند در طول بازی نجات دهد ولی در نجات جان دیگران محدودیتی ندارد.";
    roleSide = RoleSide.citizen;
    imagePath = "lib/images/roles/doctor_watson.jpg";
  }

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

  @override
  String awakingRoleText() {
    return "دکتر بیدار شه و یک نفر را نجات بده";
  }
}
