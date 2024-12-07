import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/components/last_move_card_tile.dart';
import 'package:mafia_killer/models/last_move_card.dart';

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
}
