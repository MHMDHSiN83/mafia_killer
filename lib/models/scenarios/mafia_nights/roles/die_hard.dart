import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:json_annotation/json_annotation.dart';
part 'die_hard.g.dart';

@JsonSerializable()
class DieHard extends Role {
  int shield = 1;

  DieHard() {
    name = "جان سخت";
    description =
        "گرداننده کنستانتین را بیدار می‌کند تا او به انتخاب خود و تنها یک بار یک نفر از بازیکنان اخراجی اعم از مافیا، شهروند یا مستقل را به بازی برگرداند. غیر از نقش های افشا شده توانایی های بازیکن احضار شده ادامه پیدا می‌کند و از بین نمی‌رود و از نو نمی‌شود.";
    roleSide = RoleSide.citizen;
    cardImagePath = "lib/images/roles/constantine.jpg";
  }
  factory DieHard.fromJson(Map<String, dynamic> json) =>
      _$DieHardFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DieHardToJson(this);

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      player.uiPlayerStatus = UIPlayerStatus.targetable;
    }
  }

  @override
  String awakingRole() {
    return "جان سخت بیدار شه و بگه که میخواد از استعلامش استفاده کنه یا نه";
  }
}
