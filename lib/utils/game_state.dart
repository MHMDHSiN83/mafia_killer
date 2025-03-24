import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/last_move_card.dart';

class GameState {
  GameState(this.players, this.remainingInquiry, this.nightReport,
      this.lastMoveCards, this.killedInDayPlayer, this.silencedPlayerDuringDay);

  List<Player> players;
  List<LastMoveCard> lastMoveCards;
  int remainingInquiry;
  List<String> nightReport;
  List<Player> silencedPlayerDuringDay;
  Player? killedInDayPlayer;
  
}
