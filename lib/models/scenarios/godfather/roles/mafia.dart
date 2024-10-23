import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:json_annotation/json_annotation.dart';
part 'mafia.g.dart';

@JsonSerializable()
class Mafia extends Role {
  Mafia();
  factory Mafia.fromJson(Map<String, dynamic> json) =>
      _$MafiaFromJson(json);

  // Generated method to convert an object to JSON

  @override
  Map<String, dynamic> toJson() => _$MafiaToJson(this);
}
