import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:json_annotation/json_annotation.dart';
part 'leon.g.dart';

@JsonSerializable()
class Leon extends Role {
  int remainingAbility = 2;
  int shield = 1;

  Leon() {
    name = "لئون حرفه‌ای";
    description =
        "هر شبی که بخواهد می‌تواند به یکی از اعضای تیم مافیا شلیک کند. اما با شلیک اشتباه به شهروندان به مجازات، خودش کشته می‌شود و دکتر نمی‌تواند او را نجات دهد. لئون یک جلیقه دارد که یکبار از تیر نجات پیدا می‌کند. حداکثر دو شلیک دارد.";
    roleSide = RoleSide.citizen;
    cardImagePath = "lib/images/roles/leon.jpg";
  }
  factory Leon.fromJson(Map<String, dynamic> json) => _$LeonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LeonToJson(this);

  @override
  bool hasAbility() {
    return remainingAbility > 0;
  }

  @override
  void nightAction(Player? player) {
    if (player != null) {
      Scenario.currentScenario.nightEvents[NightEvent.shotByLeon] = [player];
      remainingAbility--;
    }
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.name == 'لئون حرفه‌ای') {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  String awakingRole() {
    return "لئون بیدار شه و به یک نفر شلیک کنه (لئون در کل بازی دو تیر دارد)";
  }

  @override
  List<String> roleDetails() {
    return ["زره در شب: $shield", "تیر: $remainingAbility"];
  }

  @override
  Map<String, int> roleAbilities() {
    return {'تیر': remainingAbility, 'زره در شب' : shield};
  }

  @override
  void saveAbilities(Map<String, int> abilities) {
    remainingAbility = abilities['تیر']!; 
    shield = abilities['زره در شب']!; 
  }
}
