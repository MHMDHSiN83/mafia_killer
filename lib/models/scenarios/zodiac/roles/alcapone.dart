import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';

import 'package:json_annotation/json_annotation.dart';
part 'alcapone.g.dart';

@JsonSerializable()
class Alcapone extends Role {
  Alcapone() {
    name = "آل کاپون";
    description = "salam";
    roleSide = RoleSide.mafia;
    cardImagePath = "lib/images/roles/godfather.jpg";
  }

  factory Alcapone.fromJson(Map<String, dynamic> json) =>
      _$AlcaponeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AlcaponeToJson(this);

  @override
  String introAwakingRole() {
    return 'آل کاپون لایک نشون بده';
  }
}
