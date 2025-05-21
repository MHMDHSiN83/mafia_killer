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
      ..uiPlayerStatus =
          $enumDecode(_$UIPlayerStatusEnumMap, json['uiPlayerStatus'])
      ..playerStatus =
          Player._userStatusFromJson(json['playerStatus'] as String)
      ..seenRole = json['seenRole'] as bool;

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'doesParticipate': instance.doesParticipate,
      'name': instance.name,
      'role': instance.role,
      'uiPlayerStatus': _$UIPlayerStatusEnumMap[instance.uiPlayerStatus]!,
      'playerStatus': Player._userStatusToJson(instance.playerStatus),
      'seenRole': instance.seenRole,
    };

const _$UIPlayerStatusEnumMap = {
  UIPlayerStatus.targetable: 'targetable',
  UIPlayerStatus.untargetable: 'untargetable',
};
