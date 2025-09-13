import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:json_annotation/json_annotation.dart';
part 'professional.g.dart';

@JsonSerializable()
class Professional extends Role {
  int remainingAbility = 2;

  Professional() {
    name = "حرفه‌ای";
    description =
        "هر شبی که بخواهد می‌تواند به یکی از اعضای تیم مافیا شلیک کند. اما با شلیک اشتباه به شهروندان به مجازات، خودش کشته می‌شود و دکتر نمی‌تواند او را نجات دهد. لئون یک جلیقه دارد که یکبار از تیر نجات پیدا می‌کند. حداکثر دو شلیک دارد.";
    roleSide = RoleSide.citizen;
    cardImagePath = "lib/images/roles/leon.jpg";
  }
  factory Professional.fromJson(Map<String, dynamic> json) => _$ProfessionalFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfessionalToJson(this);

  @override
  bool hasAbility() {
    return remainingAbility > 0;
  }

  @override
  void nightAction(Player? player) {
    if (player != null) {
      Scenario.currentScenario.nightEvents[NightEvent.shotByProfessional] = [player];
      remainingAbility--;
    }
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.name == 'حرفه‌ای') {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  String awakingRole() {
    return "حرفه‌ای بیدار شه و به یک نفر شلیک کنه";
  }

  @override
  List<String> roleDetails() {
    return ["تیر: $remainingAbility"];
  }

  @override
  Map<String, int> roleAbilities() {
    return {'تیر': remainingAbility};
  }

  @override
  void saveAbilities(Map<String, int> abilities) {
    remainingAbility = abilities['تیر']!;
  }
}
