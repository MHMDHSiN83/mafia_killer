// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'citizen_kane.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CitizenKane _$CitizenKaneFromJson(Map<String, dynamic> json) => CitizenKane()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..cardImagePath = json['cardImagePath'] as String
  ..characterImagePath = json['characterImagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide'])
  ..remainingAbility = (json['remainingAbility'] as num).toInt();

Map<String, dynamic> _$CitizenKaneToJson(CitizenKane instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'cardImagePath': instance.cardImagePath,
      'characterImagePath': instance.characterImagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
      'remainingAbility': instance.remainingAbility,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
