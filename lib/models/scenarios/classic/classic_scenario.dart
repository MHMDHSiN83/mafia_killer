import 'package:json_annotation/json_annotation.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/night_event.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';

part 'classic_scenario.g.dart';

@JsonSerializable()
class ClassicScenario extends Scenario {
  ClassicScenario() : super();

  factory ClassicScenario.fromJson(Map<String, dynamic> json) =>
      _$ClassicScenarioFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClassicScenarioToJson(this);

  @override
  String validateConditions() {
    String error = super.validateConditions();

    if (error != '') {
      return error;
    }

    int mafiaCount = getNumberOfRoleBySide(RoleSide.mafia);
    int citizenCount = getNumberOfRoleBySide(RoleSide.citizen);

    if (citizenCount <= mafiaCount) {
      error = 'تعداد مافیاها باید از شهروندها کمتر باشه';
      return error;
    }
    
    return error;
  }
}
