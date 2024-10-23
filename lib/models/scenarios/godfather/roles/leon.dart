import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:json_annotation/json_annotation.dart';
part 'leon.g.dart';

@JsonSerializable()
class Leon extends Role {
  int remainingAbility = 2;

  Leon() {
    name = "لئون حرفه‌ای";
    description =
        "هر شبی که بخواهد می‌تواند به یکی از اعضای تیم مافیا شلیک کند. اما با شلیک اشتباه به شهروندان به مجازات، خودش کشته می‌شود و دکتر نمی‌تواند او را نجات دهد. لئون یک جلیقه دارد که یکبار از تیر نجات پیدا می‌کند. حداکثر دو شلیک دارد.";
    roleSide = RoleSide.citizen;
    imagePath = "lib/images/roles/leon.jpg";
  }
  factory Leon.fromJson(Map<String, dynamic> json) =>
      _$LeonFromJson(json);

  // Generated method to convert an object to JSON

  @override
  Map<String, dynamic> toJson() => _$LeonToJson(this);

  @override
  bool hasAbility() {
    return remainingAbility > 0;
  }

  @override
  void nightAction(Player player) {
    GodfatherScenario.nightEvents?[NightEvent.ShotByLeon] = player;
    remainingAbility--;
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.name == 'لئون حرفه‌ای') {
        player.playerStatus = PlayerStatus.Disable;
      }
    }
  }

  @override
  String awakingRoleText() {
    return "لئون بیدار شه و به یک نفر شلیک کنه (لئون در کل بازی دو تیر دارد)";
  }
}
