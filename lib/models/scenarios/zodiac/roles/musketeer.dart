import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/models/ui_player_status.dart';

part 'musketeer.g.dart';

@JsonSerializable()
class Musketeer extends Role {
  int remainingAbility = 3;
  bool hasRealGun = true;

  Musketeer() {
    name = "تفنگ دار";
    // description if needed
    roleSide = RoleSide.citizen;
    cardImagePath = "lib/images/roles/godfather.jpg";
  }

  factory Musketeer.fromJson(Map<String, dynamic> json) =>
      _$MusketeerFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MusketeerToJson(this);

  // TODO: isReal argument
  @override
  void nightAction(Player? player, {int? action}) {
    bool isReal = (action == 1);
    if (player != null && (!isReal || hasRealGun)) {
      Scenario.currentScenario.nightEvents[(isReal)
          ? NightEvent.realGunByMusketeer
          : NightEvent.fakeGunByMusketeer] = [player];
      remainingAbility--;
      if (isReal) hasRealGun = false;
    }
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.name is Musketeer) {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  String awakingRole() {
    return " تفنگ دار آیا میخواد به کسی تفنگ بده؟ اگر آره ی نفرو به من نشون بده و با لایک و دیس لایک بگه تیرش جنگیه یا مشقی";
  }

  @override
  bool hasAbility() {
    return hasRealGun;
  }

  @override
  List<String> roleDetails() {
    return [
      " تیر جنگی: ${hasRealGun ? 1 : 0}\n تیر مشقی: ${remainingAbility - (hasRealGun ? 1 : 0)}"
    ];
  }
}
