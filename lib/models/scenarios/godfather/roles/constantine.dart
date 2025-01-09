import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:json_annotation/json_annotation.dart';
part 'constantine.g.dart';

@JsonSerializable()
class Constantine extends Role {
  int remainingAbility = 1;

  Constantine() {
    name = "کنستانتین";
    description =
        "گرداننده کنستانتین را بیدار می‌کند تا او به انتخاب خود و تنها یک بار یک نفر از بازیکنان اخراجی اعم از مافیا، شهروند یا مستقل را به بازی برگرداند. غیر از نقش های افشا شده توانایی های بازیکن احضار شده ادامه پیدا می‌کند و از بین نمی‌رود و از نو نمی‌شود.";
    roleSide = RoleSide.citizen;
    cardImagePath = "lib/images/roles/constantine.jpg";
  }
  factory Constantine.fromJson(Map<String, dynamic> json) =>
      _$ConstantineFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ConstantineToJson(this);
  @override
  bool hasAbility() {
    return remainingAbility > 0;
  }

  @override
  void nightAction(Player? player) {
    Scenario.currentScenario.nightEvents[NightEvent.revivedByConstantine] = player;
    if (player != null) {
      remainingAbility--;
    }
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.playerStatus == PlayerStatus.dead) {
        player.uiPlayerStatus = UIPlayerStatus.targetable;
      } else {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  String awakingRole() {
    return "کنستانتین بیدار شه و یک نفر را به بازی برگردونه";
  }
}
