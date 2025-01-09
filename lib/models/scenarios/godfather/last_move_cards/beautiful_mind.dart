import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/pages/last_move_card_pages/beautiful_mind_choose_nostradamus_page.dart';

part 'beautiful_mind.g.dart';

@JsonSerializable()
class BeautifulMind extends LastMoveCard {
  BeautifulMind();

  factory BeautifulMind.fromJson(Map<String, dynamic> json) =>
      _$BeautifulMindFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BeautifulMindToJson(this);

  @override
  int titleHorizontalRatio() {
    return 5;
  }

  @override
  int rightSpaceOfTitleHorizontalRatio() {
    return 7;
  }

  @override
  void lastMoveCardAction(List<Player> players) {
    // killed player in day be nostradamus
    if (players[0].name == players[1].name && players[0].role! is Nostradamus) {
      (players[0].role! as Nostradamus).shield = false;
    }
    // guess the nostradamus correctly
    else if (players[1].role! is Nostradamus) {
      players[1].playerStatus = PlayerStatus.removed;
    }
    // guess the nostradamus wrong
    else {
      players[0].playerStatus = PlayerStatus.dead;
    }
  }

  void lastMoveCardMessage(List<Player> players) {

    // killed player in day be nostradamus
    if (players[0].name == players[1].name && players[0].role! is Nostradamus) {
      BeautifulMindChooseNostradamusPage.message =
          "${players[0].name} خودش نوستراداموس بازی است و به بازی میگردد ولی شیلدش می افتد.";
    }
    // guess the nostradamus correctly
    else if (players[1].role! is Nostradamus) {
      BeautifulMindChooseNostradamusPage.message =
          "${players[1].name} نوستراداموس است و از بازی به طور کامل خارج شده و ${players[0].name} در بازی می‌ماند";
    }
    // guess the nostradamus wrong
    else {
      BeautifulMindChooseNostradamusPage.message =
          "${players[1].name} نوستراداموس بازی نیست پس ${players[0].name} از بازی خارج میشود.";
    }
  }
}
