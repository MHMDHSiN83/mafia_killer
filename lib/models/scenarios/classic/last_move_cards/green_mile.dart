import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/classic/classic_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';

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
    (Scenario.currentScenario as ClassicScenario).permanentGreenMilePlayerName = players[1].name;
    (Scenario.currentScenario as ClassicScenario).greenMilePlayerName = players[1].name;
  }

  @override
  void undoLastMoveCardAction(List<Player> players) {
    players[0].playerStatus = PlayerStatus.active;
    (Scenario.currentScenario as ClassicScenario).permanentGreenMilePlayerName = null;
    (Scenario.currentScenario as ClassicScenario).greenMilePlayerName = null;
  }
}
