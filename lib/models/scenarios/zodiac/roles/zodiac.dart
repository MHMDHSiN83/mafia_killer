import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:json_annotation/json_annotation.dart';
part 'zodiac.g.dart';

@JsonSerializable()
class Zodiac extends Role {
  Zodiac() {
    name = "زودیاک";
    // TODO: description

    roleSide = RoleSide.independant;
    cardImagePath = "lib/images/roles/nostradamus.jpg";
  }

  factory Zodiac.fromJson(Map<String, dynamic> json) => _$ZodiacFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ZodiacToJson(this);

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.name == 'زودیاک') {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  void nightAction(Player? player, {int? action}) {
    if (player != null) {
      Scenario.currentScenario.nightEvents[NightEvent.shotByZodiac] = [player];
    }
  }

  @override
  String awakingRole() {
    return "زودیاک بیدار شه و یک نفرو بکشه";
  }
}
