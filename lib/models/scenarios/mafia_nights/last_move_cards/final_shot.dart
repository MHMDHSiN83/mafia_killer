import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/mafia_nights_scenario.dart';

part 'final_shot.g.dart';

@JsonSerializable()
class FinalShot extends LastMoveCard {
  FinalShot();

  factory FinalShot.fromJson(Map<String, dynamic> json) =>
      _$FinalShotFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FinalShotToJson(this);

  @override
  int titleHorizontalRatio() {
    return 8;
  }

  @override
  int rightSpaceOfTitleHorizontalRatio() {
    return 11;
  }

  @override
  void lastMoveCardAction(List<Player> players) {
    players[0].playerStatus = PlayerStatus.dead;
    (Scenario.currentScenario as MafiaNightsScenario).permanentFinalShotPlayerName =
        players[1].name;
    (Scenario.currentScenario as MafiaNightsScenario).finalShotPlayerName =
        players[1].name;
  }

  @override
  void undoLastMoveCardAction(List<Player> players) {
    players[0].playerStatus = PlayerStatus.active;
    (Scenario.currentScenario as MafiaNightsScenario).permanentFinalShotPlayerName =
        null;
    (Scenario.currentScenario as MafiaNightsScenario).finalShotPlayerName = null;
  }
}
