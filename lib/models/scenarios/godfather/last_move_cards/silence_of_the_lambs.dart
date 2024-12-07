import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/components/last_move_card_tile.dart';
import 'package:mafia_killer/models/last_move_card.dart';

part 'silence_of_the_lambs.g.dart';

@JsonSerializable()
class SilenceOfTheLambs extends LastMoveCard {
  SilenceOfTheLambs();

  factory SilenceOfTheLambs.fromJson(Map<String, dynamic> json) =>
      _$SilenceOfTheLambsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SilenceOfTheLambsToJson(this);


  @override
  int titleHorizontalRatio() {
    return 20;
  }

  @override
  int descriptionHorizontalRatio() {
    return 2;
  }

}
