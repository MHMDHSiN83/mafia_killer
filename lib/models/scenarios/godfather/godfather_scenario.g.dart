// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'godfather_scenario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GodfatherScenario _$GodfatherScenarioFromJson(Map<String, dynamic> json) =>
    GodfatherScenario()
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
      ..currentPlayerAtNight = json['currentPlayerAtNight'] == null
          ? null
          : Player.fromJson(
              json['currentPlayerAtNight'] as Map<String, dynamic>)
      ..ableToSelectTile = json['ableToSelectTile'] as bool
      ..immediateResponse = json['immediateResponse'] as String?
      ..nightEvents = (json['nightEvents'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$NightEventEnumMap, k),
            (e as List<dynamic>)
                .map((e) => Player.fromJson(e as Map<String, dynamic>))
                .toList()),
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

Map<String, dynamic> _$GodfatherScenarioToJson(GodfatherScenario instance) =>
    <String, dynamic>{
      'name': instance.name,
      'roles': instance.roles,
      'lastMoveCards': instance.lastMoveCards,
      'inGameLastMoveCards': instance.inGameLastMoveCards,
      'recommendedLastMoveCards': instance.recommendedLastMoveCards,
      'inGameRoles': instance.inGameRoles,
      'currentPlayerAtNight': instance.currentPlayerAtNight,
      'ableToSelectTile': instance.ableToSelectTile,
      'immediateResponse': instance.immediateResponse,
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
  NightEvent.savedByDoctorLecter: 'savedByDoctorLecter',
  NightEvent.oppositedByJoker: 'oppositedByJoker',
  NightEvent.shotByProfessional: 'shotByProfessional',
  NightEvent.silencedByTherapist: 'silencedByTherapist',
};
