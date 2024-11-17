// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nostradamus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nostradamus _$NostradamusFromJson(Map<String, dynamic> json) => Nostradamus()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..cardImagePath = json['cardImagePath'] as String
  ..characterImagePath = json['characterImagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide'])
  ..inGameRoleSide = $enumDecode(_$RoleSideEnumMap, json['inGameRoleSide']);

Map<String, dynamic> _$NostradamusToJson(Nostradamus instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'cardImagePath': instance.cardImagePath,
      'characterImagePath': instance.characterImagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
      'inGameRoleSide': _$RoleSideEnumMap[instance.inGameRoleSide]!,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
