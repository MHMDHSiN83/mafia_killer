import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';

part 'red_carpet.g.dart';

@JsonSerializable()
class RedCarpet extends LastMoveCard {
  RedCarpet();

  factory RedCarpet.fromJson(Map<String, dynamic> json) =>
      _$RedCarpetFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RedCarpetToJson(this);

  @override
  int titleHorizontalRatio() {
    return 10;
  }

  @override
  int rightSpaceOfTitleHorizontalRatio() {
    return 12;
  }

  @override
  void lastMoveCardAction(List<Player> players) {
    players[0].playerStatus = PlayerStatus.removed;
  }

  @override
  void undoLastMoveCardAction(List<Player> players) {
    players[0].playerStatus = PlayerStatus.active;
  }
}
