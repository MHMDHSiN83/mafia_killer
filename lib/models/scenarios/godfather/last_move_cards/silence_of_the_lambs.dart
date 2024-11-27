import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/models/last_move_card.dart';

part 'silence_of_the_lambs.g.dart';

@JsonSerializable()
class SilenceOfTheLambs extends LastMoveCard {
  SilenceOfTheLambs();

  factory SilenceOfTheLambs.fromJson(Map<String, dynamic> json) =>
      _$SilenceOfTheLambsFromJson(json);

  Map<String, dynamic> toJson() => _$SilenceOfTheLambsToJson(this);
}
