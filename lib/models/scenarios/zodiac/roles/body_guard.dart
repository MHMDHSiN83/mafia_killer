import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/models/scenarios/zodiac/roles/zodiac.dart';
import 'package:mafia_killer/models/scenarios/zodiac/zodiac_scenario.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
part 'body_guard.g.dart';

@JsonSerializable()
class BodyGuard extends Role {

  BodyGuard() {
    name = "محافظ";
    // description if needed
    roleSide = RoleSide.citizen;
    cardImagePath = "lib/images/roles/godfather.jpg";
  }

  factory BodyGuard.fromJson(Map<String, dynamic> json) =>
      _$BodyGuardFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BodyGuardToJson(this);

  // TODO: noon action
  @override
  void nightAction(Player? player) {
    if (player != null) {
      if ((Scenario.currentScenario as ZodiacScenario).bodyGuardGuess !=
          (Scenario.currentScenario as ZodiacScenario).bombPassword) {
        (Scenario.currentScenario as ZodiacScenario).explodedPlayer = player;
      }
    }
  }


  @override
  String awakingRole() {
    return "محافظ از خواب بیدار شه و به من بگه آیا میخواد خودشو فدا کنه و رمزو حدس بزنه";
  }



}
