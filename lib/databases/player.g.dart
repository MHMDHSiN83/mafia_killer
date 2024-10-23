// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      json['name'] as String,
    )
      ..doesParticipate = json['doesParticipate'] as bool
      ..role = json['role'] == null
          ? null
          : Role.fromJson(json['role'] as Map<String, dynamic>)
      ..playerStatus = $enumDecode(_$PlayerStatusEnumMap, json['playerStatus'])
      ..seenRole = json['seenRole'] as bool;

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'doesParticipate': instance.doesParticipate,
      'name': instance.name,
      'role': instance.role,
      'playerStatus': _$PlayerStatusEnumMap[instance.playerStatus]!,
      'seenRole': instance.seenRole,
    };

const _$PlayerStatusEnumMap = {
  PlayerStatus.Active: 'Active',
  PlayerStatus.Disable: 'Disable',
  PlayerStatus.Dead: 'Dead',
  PlayerStatus.Removed: 'Removed',
};
