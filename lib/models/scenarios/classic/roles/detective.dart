import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:json_annotation/json_annotation.dart';
part 'detective.g.dart';

@JsonSerializable()
class Detective extends Role {
  Detective() {
    name = "کارآگاه";
    description =
        "شهروندی است که در یکی از شب ها به انتخاب خود به دعوت گرداننده یکی از بازیکنان را نشان می‌دهد. اگر یک مافیا را درست نشان کرده باشد صبح روز بعد گرداننده ساید مافیای نشان شده را در جمع افشا می‌کند و همشهری کن شب بعد کشته می‌شود. دکتر توانایی نجات او را ندارد. اما اگر نشانش از ساید مافیا نبود، گرداننده هیچ چیزی اعلام نخواهد کرد و همشهری کین در بازی خواهد ماند و استعلامش از بین خواهد رفت. اگر او یا نشانش کشته شوند عملیات شب وی اجرا نشده و از بین نمی‌رود و همچنان باقی می‌ماند. استعلام پدرخوانده برای همشهری کین مافیایی است.";
    roleSide = RoleSide.citizen;
    cardImagePath = "lib/images/roles/citizen_kane.jpg";
  }
  factory Detective.fromJson(Map<String, dynamic> json) =>
      _$DetectiveFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DetectiveToJson(this);

  @override
  void nightAction(Player? player) {
    if (player != null) {
      Scenario.currentScenario.nightEvents[NightEvent.inquiryByDetective] = [
        player
      ];
    }
  }

  @override
  void setAvailablePlayers() {
    for (Player player in Player.inGamePlayers) {
      if (player.role!.name == 'کارآگاه') {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      }
    }
  }

  @override
  String awakingRole() {
    return "کارآگاه بیدار شه و استعلام یک نفر رو از من بگیره";
  }
}
