import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/player_status.dart';
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
    imagePath = "lib/images/roles/matador.jpg";
  }
  factory Matador.fromJson(Map<String, dynamic> json) =>
      _$MatadorFromJson(json);

  // Generated method to convert an object to JSON

  @override
  Map<String, dynamic> toJson() => _$MatadorToJson(this);
  @override
  void nightAction(Player player) {
    GodfatherScenario.nightEvents?[NightEvent.DisabledByMatador] = player;
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.roleSide == RoleSide.mafia) {
        player.playerStatus = PlayerStatus.Disable;
      }
    }
  }
}
