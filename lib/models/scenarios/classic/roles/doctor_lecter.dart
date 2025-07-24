import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:json_annotation/json_annotation.dart';
part 'doctor_lecter.g.dart';

@JsonSerializable()
class DoctorLecter extends Role {
  int selfHeal = 1;

  DoctorLecter() {
    name = "دکتر لکتر";
    description =
        "اگر فردی از گروه مافیا خارج شود ساول می‌تواند جای شلیک شب، معامله و خریداری انجام دهد. ساول گودمن فقط یکبار می‌تواند یکی از شهروندان ساده را به یک مافیای ساده تبدیل کند. با علامت او همان شب گرداننده آن فرد را از نقش جدیدش یعنی مافیای ساده مطلع می‌کند و وی را بیدار می‌کند تا هم تیمی های خود را بشناسد. اگر ساول گودمن شهروند غیرساده یا نوستراداموس را انتخاب کند با ضربدر گرداننده مواجه شده و گرداننده نشانش را بیدار نمی‌کند. توانمندی ساول و شلیک آن شب مافیا نیز از بین می‌رود.";
    roleSide = RoleSide.mafia;
    cardImagePath = "lib/images/roles/saul_goodman.jpg";
  }

  factory DoctorLecter.fromJson(Map<String, dynamic> json) =>
      _$DoctorLecterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DoctorLecterToJson(this);

  @override
  void nightAction(Player? player) {
    if (player != null) {
      Scenario.currentScenario.nightEvents[NightEvent.savedByDoctorLecter] = [player];
      if (player.role!.name == 'دکتر لکتر') {
        selfHeal--;
      }
    }
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.roleSide == RoleSide.mafia) {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  String introAwakingRole() {
    return 'دکتر لکتر لایک نشون بده';
  }

  @override
  List<String> roleDetails() {
    return ["نجات خود: $selfHeal"];
  }

  @override
  Map<String, int> roleAbilities() {
    return {'نجات خود': selfHeal};
  }

  @override
  void saveAbilities(Map<String, int> abilities) {
    selfHeal = abilities['نجات خود']!; 
  }
}
