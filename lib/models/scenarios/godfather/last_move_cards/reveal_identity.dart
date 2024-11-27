import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/models/last_move_card.dart';

part 'reveal_identity.g.dart';

@JsonSerializable()
class RevealIdentity extends LastMoveCard {
  RevealIdentity();

  factory RevealIdentity.fromJson(Map<String, dynamic> json) =>
      _$RevealIdentityFromJson(json);
  Map<String, dynamic> toJson() => _$RevealIdentityToJson(this);
}
