import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor extends Role {
  int selfHeal = 2;
  int multiSelectionNumber = 2;

  Doctor() {
    name = "دکتر";
    description =
        "هر شب می‌تواند جان یک نفر چه عضو مافیا و چه عضو شهروندی را نجات دهد. جان خودش را یکبار می‌تواند در طول بازی نجات دهد ولی در نجات جان دیگران محدودیتی ندارد.";
    roleSide = RoleSide.citizen;
    cardImagePath = "lib/images/roles/doctor_watson.jpg";
  }

  factory Doctor.fromJson(Map<String, dynamic> json) =>
      _$DoctorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DoctorToJson(this);

  @override
  void nightAction(Player? player) {
    if (player != null) {
      Scenario.currentScenario
          .addPlayerToNightEvent(NightEvent.savedByDoctor, player);
      if (player.role!.name == 'دکتر') {
        selfHeal--;
      }
    }
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.name == 'دکتر' && selfHeal <= 0) {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  String awakingRole() {
    setAvailablePlayers();
    return "دکتر بیدار شه و ${Language.getPersianNumberWord(multiSelectionNumber)}"
        " نفر را نجات بده";
  }

  @override
  List<String> roleDetails() {
    return ["نجات خود: $selfHeal"];
  }

  @override
  Map<String, int> roleAbilities() {
    return {'نجات خود': selfHeal, 'نجات در هر شب': multiSelectionNumber};
  }

  @override
  void saveAbilities(Map<String, int> abilities) {
    selfHeal = abilities['نجات خود']!;
    multiSelectionNumber = abilities['نجات در هر شب']!;
  }

  @override
  bool hasMultiSelection() {
    return multiSelectionNumber > 1;
  }

  @override
  bool hasAllSelected(int number) {
    return number == multiSelectionNumber;
  }
}
