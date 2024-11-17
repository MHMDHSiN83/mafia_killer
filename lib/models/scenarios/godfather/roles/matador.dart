import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:json_annotation/json_annotation.dart';
part 'matador.g.dart';

@JsonSerializable()
class Matador extends Role {
  Matador() {
    name = "ماتادور";
    description =
        "شب ها با تیم مافیا بیدار می‌شود و هر شب از توانایی خود استفاده می‌کند. در شب هر بازیکنی را نشان دهد توانایی شب او را آن شب از وی خواهد گرفت و فرد نشان شده اگر بیدار شود با ضربدر گرداننده مواجه می‌شود اما فردا مجدد می‌تواند از توانایی‌اش استفاده کند. ماتادور دو شب متوالی نمی‌تواند یک بازیکن را نشان کند.";
    roleSide = RoleSide.mafia;
    cardImagePath = "lib/images/roles/matador.jpg";
  }

  String? lastPlayerName;

  factory Matador.fromJson(Map<String, dynamic> json) =>
      _$MatadorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MatadorToJson(this);
  @override
  void nightAction(Player? player) {
    GodfatherScenario.nightEvents[NightEvent.disabledByMatador] = player;
    if (player != null) {
      player.playerStatus = PlayerStatus.disable;
    }
  }

  @override
  void setAvailablePlayers() {
    // TODO can't disable someone two night in a row
    for (Player player in Player.inGamePlayers) {
      if (player.role!.roleSide == RoleSide.mafia) {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  String awakingRole() {
    return "ماتادور توانایی یک نفر رو امشب ازش بگیره";
  }

  @override
  String sleepRoleText() {
    // TODO: implement sleepRoleText
    return "تیم مافیا بخوابه";
  }

  @override
  String introAwakingRole() {
    return 'ماتادور لایک نشون بده';
  }
}
