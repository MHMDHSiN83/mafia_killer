import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';

part 'great_lie.g.dart';

@JsonSerializable()
class GreatLie extends LastMoveCard {
  GreatLie();

  factory GreatLie.fromJson(Map<String, dynamic> json) =>
      _$GreatLieFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GreatLieToJson(this);

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
    players[0].playerStatus = PlayerStatus.dead;
  }

  @override
  void undoLastMoveCardAction(List<Player> players) {
    players[0].playerStatus = PlayerStatus.active;
  }
}
