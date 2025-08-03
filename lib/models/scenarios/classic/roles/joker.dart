import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:json_annotation/json_annotation.dart';
part 'joker.g.dart';

@JsonSerializable()
class Joker extends Role {
  Joker() {
    name = "جوکر";
    description =
        "شب ها با تیم مافیا بیدار می‌شود و هر شب از توانایی خود استفاده می‌کند. در شب هر بازیکنی را نشان دهد توانایی شب او را آن شب از وی خواهد گرفت و فرد نشان شده اگر بیدار شود با ضربدر گرداننده مواجه می‌شود اما فردا مجدد می‌تواند از توانایی‌اش استفاده کند. ماتادور دو شب متوالی نمی‌تواند یک بازیکن را نشان کند.";
    roleSide = RoleSide.mafia;
    cardImagePath = "lib/images/roles/matador.jpg";
  }

  String? lastPlayerName; // TODO: need this?

  factory Joker.fromJson(Map<String, dynamic> json) =>
      _$JokerFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JokerToJson(this);
  @override
  void nightAction(Player? player) {
    if (player != null) {
      Scenario.currentScenario.nightEvents[NightEvent.oppositedByJoker] = [player];
      lastPlayerName = player.name;
    }
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.roleSide == RoleSide.mafia ||
          (lastPlayerName != null && lastPlayerName == player.name)) {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  String awakingRole() {
    return "جوکر توانایی یک نفر رو امشب ازش بگیره";
  }

  @override
  String sleepRoleText() {
    return "تیم مافیا بخوابه";
  }

  @override
  String introAwakingRole() {
    return 'جوکر لایک نشون بده';
  }

  @override
  List<String> roleDetails() {
    return (lastPlayerName == null) ? [] : ["بازیکن قبلی: \n $lastPlayerName"];
  }
}
