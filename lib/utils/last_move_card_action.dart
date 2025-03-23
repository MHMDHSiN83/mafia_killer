import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/last_move_card.dart';

class LastMoveCardAction {
  LastMoveCardAction(this.players, this.lastMoveCard);

  List<Player> players;
  LastMoveCard lastMoveCard;
}
