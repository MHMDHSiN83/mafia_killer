import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/components/last_move_card_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';

part 'beautiful_mind.g.dart';

@JsonSerializable()
class BeautifulMind extends LastMoveCard {
  BeautifulMind();

  factory BeautifulMind.fromJson(Map<String, dynamic> json) =>
      _$BeautifulMindFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BeautifulMindToJson(this);

  @override
  int titleHorizontalRatio() {
    return 5;
  }

  @override
  int rightSpaceOfTitleHorizontalRatio() {
    return 7;
  }

  @override
  void lastMoveCardAction(List<Player> players, bool succeed) {
    if (succeed) {
      if (players[0].role! is Nostradamus) {
        (players[0].role! as Nostradamus).shield = false;
      } else {
        for (int i = 0; i < Player.inGamePlayers.length; i++) {
          if (Player.inGamePlayers[i].role! is Nostradamus) {
            Player.inGamePlayers[i].playerStatus = PlayerStatus.removed;
          }
        }
      }
    } else {
      players[0].playerStatus = PlayerStatus.dead;
    }
  }
}
