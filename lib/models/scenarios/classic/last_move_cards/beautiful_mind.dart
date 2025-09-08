import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/classic/classic_scenario.dart';

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
    if (!(Scenario.currentScenario as ClassicScenario)
        .hasGuessedRightForBeautifulMind) {
      players[0].playerStatus = PlayerStatus.dead;
    }
  }

  @override
  void undoLastMoveCardAction(List<Player> players) {
    if (!(Scenario.currentScenario as ClassicScenario)
        .hasGuessedRightForBeautifulMind) {
      players[0].playerStatus = PlayerStatus.active;
    }
  }
}
