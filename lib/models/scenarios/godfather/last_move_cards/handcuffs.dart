import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/models/last_move_card.dart';

part 'handcuffs.g.dart';

@JsonSerializable()
class Handcuffs extends LastMoveCard {
  Handcuffs();

  factory Handcuffs.fromJson(Map<String, dynamic> json) =>
      _$HandcuffsFromJson(json);

  Map<String, dynamic> toJson() => _$HandcuffsToJson(this);
}
