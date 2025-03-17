import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';

part 'silence_of_the_lambs.g.dart';

@JsonSerializable()
class SilenceOfTheLambs extends LastMoveCard {
  SilenceOfTheLambs();

  factory SilenceOfTheLambs.fromJson(Map<String, dynamic> json) =>
      _$SilenceOfTheLambsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SilenceOfTheLambsToJson(this);

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
    for (int i = 1; i < players.length; i++) {
      (Scenario.currentScenario as GodfatherScenario)
          .silencedPlayerDuringDay
          .add(players[i]);
    }
    players[0].playerStatus = PlayerStatus.dead;
  }
}
