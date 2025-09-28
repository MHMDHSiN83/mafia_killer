import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';

part 'vertigo.g.dart';

@JsonSerializable()
class Vertigo extends LastMoveCard {
  Vertigo();

  factory Vertigo.fromJson(Map<String, dynamic> json) =>
      _$VertigoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VertigoToJson(this);

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
    for (int i = 0; i < players.length; i++) {
      players[i].playerStatus = PlayerStatus.disable;
    }
    players[0].playerStatus = PlayerStatus.dead;
  }

  @override
  void undoLastMoveCardAction(List<Player> players) {
    players[0].playerStatus = PlayerStatus.active;
    players[1].playerStatus = PlayerStatus.active;
  }
}
