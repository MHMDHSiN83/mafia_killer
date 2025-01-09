import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';

part 'classic_scenario.g.dart';

@JsonSerializable()
class ClassicScenario extends Scenario {
  ClassicScenario() : super();

  factory ClassicScenario.fromJson(Map<String, dynamic> json) =>
      _$ClassicScenarioFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClassicScenarioToJson(this);
}
