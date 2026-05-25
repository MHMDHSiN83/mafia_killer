import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Magician.g.dart';

@JsonSerializable()
class Magician extends Role {
  Magician() {
    name = "شعبده باز";
    // description if needed
    roleSide = RoleSide.mafia;
    cardImagePath = "lib/images/roles/matador.jpg";
  }
  int multiSelectionNumber = 1;
  String? lastPlayerName;

  factory Magician.fromJson(Map<String, dynamic> json) =>
      _$MagicianFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MagicianToJson(this);
  @override
  void nightAction(Player? player) {
    if (player != null) {
      Scenario.currentScenario
          .addPlayerToNightEvent(NightEvent.disabledByMagician, player);
      player.playerStatus = PlayerStatus.disable;
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
    return "شعبده باز توانایی ${Language.getPersianNumberWord(multiSelectionNumber)} نفر رو امشب ازش بگیره";
  }

  @override
  String sleepRoleText() {
    return "تیم مافیا بخوابه";
  }

  @override
  String introAwakingRole() {
    return 'شعبده باز لایک نشون بده';
  }

  @override
  List<String> roleDetails() {
    return (lastPlayerName == null) ? [] : ["بازیکن قبلی: \n $lastPlayerName"];
  }

  @override
  Map<String, int> roleAbilities() {
    return {'هدف در هر شب': multiSelectionNumber};
  }

  @override
  void saveAbilities(Map<String, int> abilities) {
    multiSelectionNumber = abilities['هدف در هر شب']!;
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
