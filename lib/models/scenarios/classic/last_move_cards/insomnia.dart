import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';

part 'insomnia.g.dart';

@JsonSerializable()
class Insomnia extends LastMoveCard {
  Insomnia();

  factory Insomnia.fromJson(Map<String, dynamic> json) =>
      _$InsomniaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InsomniaToJson(this);

  @override
  int titleHorizontalRatio() {
    return 4;
  }

  @override
  int rightSpaceOfTitleHorizontalRatio() {
    return 6;
  }

  @override
  void lastMoveCardAction(List<Player> players) {
    Player.getPlayerByName(players[0].name).playerStatus = PlayerStatus.dead;
    // players[0].playerStatus = PlayerStatus.dead;
    GameStateManager.addState(
        lastMoveCards: Scenario.currentScenario.inGameLastMoveCards,
        silencedPlayerDuringDay:
            Scenario.currentScenario.silencedPlayerDuringDay);
  }

  @override
  void undoLastMoveCardAction(List<Player> players) {
    Player.getPlayerByName(players[0].name).playerStatus = PlayerStatus.active;
    // players[0].playerStatus = PlayerStatus.active;
    GameStateManager.goToPreviousState();
  }
}
