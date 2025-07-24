import 'package:mafia_killer/models/role.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/models/role_side.dart';
part 'mafia.g.dart';

@JsonSerializable()
class Mafia extends Role {
  Mafia();
  factory Mafia.fromJson(Map<String, dynamic> json) =>
      _$MafiaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MafiaToJson(this);

  @override
  String introAwakingRole() {
    return 'مافیای ساده لایک نشون بده';
  }
}
