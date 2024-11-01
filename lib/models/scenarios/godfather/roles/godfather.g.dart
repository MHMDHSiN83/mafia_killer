// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'godfather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Godfather _$GodfatherFromJson(Map<String, dynamic> json) => Godfather()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..cardImagePath = json['cardImagePath'] as String
  ..characterImagePath = json['characterImagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide'])
  ..remainingAbility = (json['remainingAbility'] as num).toInt()
  ..shield = (json['shield'] as num).toInt();

Map<String, dynamic> _$GodfatherToJson(Godfather instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'cardImagePath': instance.cardImagePath,
      'characterImagePath': instance.characterImagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
      'remainingAbility': instance.remainingAbility,
      'shield': instance.shield,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
