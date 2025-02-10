import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';

import 'package:json_annotation/json_annotation.dart';
part 'godfather.g.dart';

@JsonSerializable()
class Godfather extends Role {
  int remainingAbility = 1;
  int shield = 1;

  Godfather() {
    name = "پدرخوانده";
    description =
        "او یک بار از شلیک شب لئون در امان است، یک جلیقه دارد. تعیین شلیک شب از طرف گروه به عهده پدرخوانده است و اگر از بازی خارج شود دیگر اعضا به جای او شلیک می‌کنند. پدرخوانده دارای توانایی حس ششم است است و اگر در شب تصمیم بگیرد به جای شلیک از حس ششم استفاده کند باید نقش بازیکنی را درست حدس بزند و توسط گرداننده تایید شود. بازیکنی که پدرخوانده نقش او را درست حدس زده است سلاخی می‌شود، یعنی اگر سپر داشته باشد یا دکتر او را سیو کرده باشد بازهم از بازی خارج می‌شود و آن شب توانایی وی اعمال نخواهد شد و پس از خروج از بازی توسط کنستانتین قابل احضار نمی‌باشد. استعلام پدرخوانده برای نوستراداموس شهروندی بوده ولی برای همشهری کین مافیایی و مثبت خواهد بود.";
    roleSide = RoleSide.mafia;
    cardImagePath = "lib/images/roles/godfather.jpg";
  }

  factory Godfather.fromJson(Map<String, dynamic> json) =>
      _$GodfatherFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GodfatherToJson(this);
  @override
  bool hasAbility() {
    return remainingAbility > 0;
  }

  @override
  void nightAction(Player? player) {
    Scenario.currentScenario.nightEvents[NightEvent.sixthSensedByGodfather] = player;
    if (player != null) {
      remainingAbility--;
    }
  }

  @override
  void setAvailablePlayers() {
    //TODO carte  harakat akhar zehn ziba
    for (Player player in Player.inGamePlayers) {
      if (player.role!.roleSide == RoleSide.mafia) {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  String introAwakingRole() {
    return 'پدرخوانده لایک نشون بده';
  }

  @override
  List<String> roleDetails() {
    return ["حس ششم: $remainingAbility", "زره در شب: $shield"];
  }
}
