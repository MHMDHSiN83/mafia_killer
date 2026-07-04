import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/models/scenarios/zodiac/roles/zodiac.dart';
import 'package:mafia_killer/models/scenarios/zodiac/zodiac_scenario.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
part 'bomber.g.dart';

@JsonSerializable()
class Bomber extends Role {
  int remainingAbility = 1;

  Bomber() {
    name = "بمب گذار";
    // description if needed
    roleSide = RoleSide.mafia;
    cardImagePath = "lib/images/roles/godfather.jpg";
  }

  factory Bomber.fromJson(Map<String, dynamic> json) => _$BomberFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BomberToJson(this);

  @override
  void nightAction(Player? player, {int? action}) {
    if (player != null) {
      Scenario.currentScenario.nightEvents[NightEvent.bombedByBomber] = [
        player
      ];
      remainingAbility--;
    }
  }

  @override
  void setAvailablePlayers() {}

  @override
  String awakingRole() {
    return "بمب گذار آیا میخواد از قابلیتش استفاده کنه؟ اگر آره ی نفرو به من نشون بده";
  }

  @override
  bool hasAbility() {
    return remainingAbility > 0;
  }
}
