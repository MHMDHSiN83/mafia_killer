// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scenario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scenario _$ScenarioFromJson(Map<String, dynamic> json) => Scenario(
      json['name'] as String,
    )
      ..roles = (json['roles'] as List<dynamic>)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList()
      ..lastMoveCards = (json['lastMoveCards'] as List<dynamic>)
          .map((e) => LastMoveCard.fromJson(e as Map<String, dynamic>))
          .toList()
      ..inGameRoles = (json['inGameRoles'] as List<dynamic>)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList()
      ..nightNumber = (json['nightNumber'] as num).toInt()
      ..dayNumber = (json['dayNumber'] as num).toInt()
      ..isNight = json['isNight'] as bool;

Map<String, dynamic> _$ScenarioToJson(Scenario instance) => <String, dynamic>{
      'name': instance.name,
      'roles': instance.roles,
      'lastMoveCards': instance.lastMoveCards,
      'inGameRoles': instance.inGameRoles,
      'nightNumber': instance.nightNumber,
      'dayNumber': instance.dayNumber,
      'isNight': instance.isNight,
    };
