import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/components/last_move_card_tile.dart';
import 'package:mafia_killer/models/last_move_card.dart';

part 'handcuffs.g.dart';

@JsonSerializable()
class Handcuffs extends LastMoveCard {
  Handcuffs();

  factory Handcuffs.fromJson(Map<String, dynamic> json) =>
      _$HandcuffsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HandcuffsToJson(this);



  @override
  int titleHorizontalRatio() {
    return 4;
  }

  @override
  int descriptionHorizontalRatio() {
    return 2;
  }
}
