import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/mafia_nights_scenario.dart';

part 'green_mile.g.dart';

@JsonSerializable()
class GreenMile extends LastMoveCard {
  GreenMile();

  factory GreenMile.fromJson(Map<String, dynamic> json) =>
      _$GreenMileFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GreenMileToJson(this);

  @override
  int titleHorizontalRatio() {
    return 20;
  }

  @override
  int rightSpaceOfTitleHorizontalRatio() {
    return 30;
  }

  @override
  void lastMoveCardAction(List<Player> players) {
    players[0].playerStatus = PlayerStatus.dead;
    (Scenario.currentScenario as MafiaNightsScenario).permanentGreenMilePlayerName = players[1].name;
    (Scenario.currentScenario as MafiaNightsScenario).greenMilePlayerName = players[1].name;
  }

  @override
  void undoLastMoveCardAction(List<Player> players) {
    players[0].playerStatus = PlayerStatus.active;
    (Scenario.currentScenario as MafiaNightsScenario).permanentGreenMilePlayerName = null;
    (Scenario.currentScenario as MafiaNightsScenario).greenMilePlayerName = null;
  }
}
