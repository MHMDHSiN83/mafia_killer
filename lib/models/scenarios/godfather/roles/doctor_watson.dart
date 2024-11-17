import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';

part 'doctor_watson.g.dart';

@JsonSerializable()
class DoctorWatson extends Role {
  int selfHeal = 2;

  DoctorWatson() {
    name = "دکتر واتسون";
    description =
        "هر شب می‌تواند جان یک نفر چه عضو مافیا و چه عضو شهروندی را نجات دهد. جان خودش را یکبار می‌تواند در طول بازی نجات دهد ولی در نجات جان دیگران محدودیتی ندارد.";
    roleSide = RoleSide.citizen;
    cardImagePath = "lib/images/roles/doctor_watson.jpg";
  }

  factory DoctorWatson.fromJson(Map<String, dynamic> json) =>
      _$DoctorWatsonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DoctorWatsonToJson(this);

  @override
  void nightAction(Player? player) {
    GodfatherScenario.nightEvents[NightEvent.savedByDoctor] = player;
    if (player != null) {
      if (player.role!.name == 'دکتر واتسون') {
        selfHeal--;
      }
    }
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.name == 'دکتر واتسون' && selfHeal <= 0) {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  String awakingRole() {
    setAvailablePlayers();
    return "دکتر بیدار شه و یک نفر را نجات بده";
  }
}
