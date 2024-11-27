import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/models/last_move_card.dart';

part 'face_off.g.dart';

@JsonSerializable()
class FaceOff extends LastMoveCard {
  FaceOff();

  factory FaceOff.fromJson(Map<String, dynamic> json) =>
      _$FaceOffFromJson(json);

  Map<String, dynamic> toJson() => _$FaceOffToJson(this);
}
