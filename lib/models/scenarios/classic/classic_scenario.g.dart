// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classic_scenario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassicScenario _$ClassicScenarioFromJson(Map<String, dynamic> json) =>
    ClassicScenario()
      ..name = json['name'] as String
      ..roles = (json['roles'] as List<dynamic>)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList()
      ..lastMoveCards = (json['lastMoveCards'] as List<dynamic>)
          .map((e) => LastMoveCard.fromJson(e as Map<String, dynamic>))
          .toList()
      ..inGameLastMoveCards = (json['inGameLastMoveCards'] as List<dynamic>)
          .map((e) => LastMoveCard.fromJson(e as Map<String, dynamic>))
          .toList()
      ..recommendedLastMoveCards =
          (json['recommendedLastMoveCards'] as List<dynamic>)
              .map((e) => LastMoveCard.fromJson(e as Map<String, dynamic>))
              .toList()
      ..inGameRoles = (json['inGameRoles'] as List<dynamic>)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList()
      ..nightEvents = (json['nightEvents'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$NightEventEnumMap, k),
            e == null ? null : Player.fromJson(e as Map<String, dynamic>)),
      )
      ..defendingPlayers = (json['defendingPlayers'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList()
      ..killedInDayPlayer = json['killedInDayPlayer'] == null
          ? null
          : Player.fromJson(json['killedInDayPlayer'] as Map<String, dynamic>)
      ..silencedPlayerDuringDay =
          (json['silencedPlayerDuringDay'] as List<dynamic>)
              .map((e) => Player.fromJson(e as Map<String, dynamic>))
              .toList()
      ..report =
          (json['report'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$ClassicScenarioToJson(ClassicScenario instance) =>
    <String, dynamic>{
      'name': instance.name,
      'roles': instance.roles,
      'lastMoveCards': instance.lastMoveCards,
      'inGameLastMoveCards': instance.inGameLastMoveCards,
      'recommendedLastMoveCards': instance.recommendedLastMoveCards,
      'inGameRoles': instance.inGameRoles,
      'nightEvents': instance.nightEvents
          .map((k, e) => MapEntry(_$NightEventEnumMap[k]!, e)),
      'defendingPlayers': instance.defendingPlayers,
      'killedInDayPlayer': instance.killedInDayPlayer,
      'silencedPlayerDuringDay': instance.silencedPlayerDuringDay,
      'report': instance.report,
    };

const _$NightEventEnumMap = {
  NightEvent.savedByDoctor: 'savedByDoctor',
  NightEvent.shotByMafia: 'shotByMafia',
  NightEvent.sixthSensedByGodfather: 'sixthSensedByGodfather',
  NightEvent.shotByLeon: 'shotByLeon',
  NightEvent.revivedByConstantine: 'revivedByConstantine',
  NightEvent.inquiryByCitizenKane: 'inquiryByCitizenKane',
  NightEvent.boughtBySaulGoodman: 'boughtBySaulGoodman',
  NightEvent.disabledByMatador: 'disabledByMatador',
};
