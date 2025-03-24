import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/utils/game_state.dart';
import 'package:mafia_killer/utils/last_move_card_action.dart';

class GameStateManager {
  static Map<String, GameState> gameStates = {};
  static Map<String, LastMoveCardAction> lastMoveCardActions = {};
  static String currentState = 'n0';

  static addState({
    List<String>? nightReport,
    List<LastMoveCard>? lastMoveCards,
    List<Player>? silencedPlayerDuringDay,
  }) {
    List<Player> statePlayers = [];
    List<LastMoveCard> stateLastMoveCards = [];
    List<Player> stateSilencedPlayerDuringDay = [];
    Player? stateKilledInDayPlayer;
    if (Scenario.currentScenario.killedInDayPlayer != null) {
      stateKilledInDayPlayer =
          Player.copy(Scenario.currentScenario.killedInDayPlayer!);
    }

    for (Player p in Player.inGamePlayers) {
      statePlayers.add(Player.copy(p));
    }
    nightReport ??= [];
    if (lastMoveCards != null) {
      for (LastMoveCard l in lastMoveCards) {
        stateLastMoveCards.add(LastMoveCard.copy(l));
      }
    }

    if (silencedPlayerDuringDay != null) {
      for (Player p in silencedPlayerDuringDay) {
        stateSilencedPlayerDuringDay.add(Player.copy(p));
      }
    } else {
      stateSilencedPlayerDuringDay = [];
    }

    GameState gameState = GameState(
        statePlayers,
        GameSettings.currentGameSettings.inquiry,
        nightReport,
        stateLastMoveCards,
        stateKilledInDayPlayer,
        stateSilencedPlayerDuringDay);
    gameStates[currentState] = gameState;
    goToNextState();
  }

  static String getNextState() {
    int? number = int.tryParse(currentState.substring(1));
    String nextState = '';
    if (currentState[0] == 'n') {
      nextState = 'd${number! + 1}';
    } else {
      nextState = 'n${number!}';
    }
    return nextState;
  }

  static void goToNextState() {
    currentState = getNextState();
  }

  static String getPreviousState() {
    int? number = int.tryParse(currentState.substring(1));
    String previousState = '';
    if (currentState[0] == 'n') {
      previousState = 'd${number!}';
    } else {
      previousState = 'n${number! - 1}';
    }
    return previousState;
  }

  static void goToPreviousState() {
    currentState = getPreviousState();
    Player.inGamePlayers = gameStates[currentState]!.players;
    Scenario.currentScenario.inGameLastMoveCards =
        gameStates[currentState]!.lastMoveCards;
    GameSettings.currentGameSettings.inquiry =
        gameStates[currentState]!.remainingInquiry;
    Scenario.currentScenario.report = gameStates[currentState]!.nightReport;
    Scenario.currentScenario.killedInDayPlayer =
        gameStates[currentState]!.killedInDayPlayer;
    Scenario.currentScenario.silencedPlayerDuringDay =
        gameStates[currentState]!.silencedPlayerDuringDay;
    undoLastMoveCardAction();
  }

  static void addLastMoveCardAction(
      List<Player> players, LastMoveCard lastMoveCard) {
    List<Player> statePlayers = [];

    for (Player p in players) {
      statePlayers.add(Player.copy(p));
    }

    LastMoveCard stateLastMoveCard = LastMoveCard.copy(lastMoveCard);
    lastMoveCardActions[currentState] =
        LastMoveCardAction(statePlayers, stateLastMoveCard);
  }

  static void undoLastMoveCardAction() {
    if (lastMoveCardActions.containsKey(currentState)) {
      LastMoveCardAction lastMoveCardAction =
          lastMoveCardActions[currentState]!;
      lastMoveCardAction.lastMoveCard.undoLastMoveCardAction(
          Player.getPlayersByName(
              Player.getPlayerNames(lastMoveCardAction.players)));
      lastMoveCardActions.remove(currentState);
    }
  }
}
