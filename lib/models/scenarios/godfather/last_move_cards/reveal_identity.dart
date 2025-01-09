import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';

part 'reveal_identity.g.dart';

@JsonSerializable()
class RevealIdentity extends LastMoveCard {
  RevealIdentity();

  factory RevealIdentity.fromJson(Map<String, dynamic> json) =>
      _$RevealIdentityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RevealIdentityToJson(this);

  @override
  int titleHorizontalRatio() {
    return 10;
  }

  @override
  int rightSpaceOfTitleHorizontalRatio() {
    return 12;
  }

  @override
  void lastMoveCardAction(List<Player> players, bool succeed) {
    players[0].playerStatus = PlayerStatus.removed;
  }
}
