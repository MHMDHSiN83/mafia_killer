import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/utils/game_state.dart';

class GameStateManager {
  static Map<String, GameState> gameStates = {};

  static String currentState = 'n0';

  static addState({
    List<String>? nightReport,
    List<LastMoveCard>? lastMoveCards,
    List<Player>? silencedPlayerDuringDay,
  }) {
    List<Player> statePlayers = [];
    List<LastMoveCard> stateLastMoveCards = [];
    for (Player p in Player.inGamePlayers) {
      statePlayers.add(Player.copy(p));
    }
    nightReport ??= [];
    if (lastMoveCards != null) {
      for (LastMoveCard l in lastMoveCards) {
        stateLastMoveCards.add(LastMoveCard.copy(l));
      }
    }

    silencedPlayerDuringDay ??= [];
    GameState gameState = GameState(statePlayers, GameSettings.currentGameSettings.inquiry, nightReport,
        stateLastMoveCards, silencedPlayerDuringDay);
    gameStates[currentState] = gameState;
    goToNextState();
  }

  static void goToNextState() {
    int? number = int.tryParse(currentState.substring(1));
    if (currentState[0] == 'n') {
      currentState = 'd${number! + 1}';
    } else {
      currentState = 'n${number!}';
    }
  }

  static void goToPreviousState() {
    int? number = int.tryParse(currentState.substring(1));
    if (currentState[0] == 'n') {
      currentState = 'd${number!}';
    } else {
      currentState = 'n${number! - 1}';
    }
  }
}
