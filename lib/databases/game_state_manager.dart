import 'package:logger/logger.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/beautiful_mind.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/face_off.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/handcuffs.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/reveal_identity.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/silence_of_the_lambs.dart';
import 'package:mafia_killer/pages/last_move_card_pages/beautiful_mind_choose_nostradamus_page.dart';
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
    for (Player p in Player.inGamePlayers) {
      statePlayers.add(Player.copy(p));
      if(p.name == 'سجاد') {
        Logger().d('this is test:');

        Logger().d(p.playerStatus);
      }
    }
    nightReport ??= [];
    if (lastMoveCards != null) {
      for (LastMoveCard l in lastMoveCards) {
        stateLastMoveCards.add(LastMoveCard.copy(l));
      }
    }

    silencedPlayerDuringDay ??= [];
    GameState gameState = GameState(
        statePlayers,
        GameSettings.currentGameSettings.inquiry,
        nightReport,
        stateLastMoveCards,
        silencedPlayerDuringDay);
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
    Logger().d(currentState);
  }

  static void undoLastMoveCardAction() {
    Logger().d("11111111111");
    if (lastMoveCardActions.containsKey(currentState)) {
    Logger().d("222222222222");

      LastMoveCardAction lastMoveCardAction =
          lastMoveCardActions[currentState]!;
      if (lastMoveCardAction.lastMoveCard is BeautifulMind) {

      } else if (lastMoveCardAction.lastMoveCard is FaceOff) {
        Logger().d("testtttttttttttttttt");
        for (Player p in Player.inGamePlayers) {
          if (p.name == lastMoveCardAction.players[0].name) {
            p.role = lastMoveCardAction.players[0].role;
            p.playerStatus = PlayerStatus.active;
          }
          if (p.name == lastMoveCardAction.players[1].name) {
            p.role = lastMoveCardAction.players[1].role;
            p.playerStatus = PlayerStatus.active;
          }
        }
      } else if (lastMoveCardAction.lastMoveCard is Handcuffs) {
      } else if (lastMoveCardAction.lastMoveCard is RevealIdentity) {
      } else if (lastMoveCardAction.lastMoveCard is SilenceOfTheLambs) {}
      lastMoveCardActions.remove(currentState);
    }
  }
}
