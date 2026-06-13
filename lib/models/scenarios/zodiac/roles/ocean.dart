import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/models/ui_player_status.dart';

part 'ocean.g.dart';

@JsonSerializable()
class Ocean extends Role {
  int remainingAbility = 2;

  Ocean() {
    name = "اوشن";
    // description if needed
    roleSide = RoleSide.citizen;
    cardImagePath = "lib/images/roles/godfather.jpg";
  }

  factory Ocean.fromJson(Map<String, dynamic> json) => _$OceanFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OceanToJson(this);

  @override
  void nightAction(Player? player, {int? action}) {
    if (player != null) {
      Scenario.currentScenario.nightEvents[NightEvent.awakedByOcean] = [player];
      remainingAbility--;
    }
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.name is Ocean) {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  String awakingRole() {
    return "اوشن و یارانش از خواب بیدار شن با هم مشورت کنن. اوشن اگر میخواد یکیو به تیمش اضافه کنه ی نفرو به من نشون بده";
  }

  @override
  bool hasAbility() {
    return remainingAbility > 0;
  }
}
