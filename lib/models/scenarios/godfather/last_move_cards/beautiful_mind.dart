import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/models/last_move_card.dart';

part 'beautiful_mind.g.dart';

@JsonSerializable()
class BeautifulMind extends LastMoveCard {
  BeautifulMind();

  factory BeautifulMind.fromJson(Map<String, dynamic> json) =>
      _$BeautifulMindFromJson(json);

  Map<String, dynamic> toJson() => _$BeautifulMindToJson(this);
}
