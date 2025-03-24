import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/role.dart';

part 'face_off.g.dart';

@JsonSerializable()
class FaceOff extends LastMoveCard {
  FaceOff();

  factory FaceOff.fromJson(Map<String, dynamic> json) =>
      _$FaceOffFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FaceOffToJson(this);

  @override
  int titleHorizontalRatio() {
    return 8;
  }

  @override
  int rightSpaceOfTitleHorizontalRatio() {
    return 11;
  }

  @override
  void lastMoveCardAction(List<Player> players) {
    // the first element of the players list is the player that is going out of the game
    players[0].playerStatus = PlayerStatus.removed;
    Role tmp = players[1].role!;
    players[1].role = players[0].role!;
    players[0].role = tmp;
  }

  @override
  void undoLastMoveCardAction(List<Player> players) {
    Role? temp = players[0].role;
    players[0].role = players[1].role;
    players[1].role = temp;
    players[0].playerStatus = PlayerStatus.active;
    players[1].playerStatus = PlayerStatus.active;
  }
}
