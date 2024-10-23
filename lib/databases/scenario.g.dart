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
      ..inGameRoles = (json['inGameRoles'] as List<dynamic>)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ScenarioToJson(Scenario instance) => <String, dynamic>{
      'name': instance.name,
      'roles': instance.roles,
      'inGameRoles': instance.inGameRoles,
    };
