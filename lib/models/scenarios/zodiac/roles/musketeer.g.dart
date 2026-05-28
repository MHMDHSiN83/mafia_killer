// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'musketeer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Musketeer _$MusketeerFromJson(Map<String, dynamic> json) => Musketeer()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..cardImagePath = json['cardImagePath'] as String
  ..characterImagePath = json['characterImagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide'])
  ..slug = json['slug'] as String
  ..remainingAbility = (json['remainingAbility'] as num).toInt()
  ..hasRealGun = json['hasRealGun'] as bool;

Map<String, dynamic> _$MusketeerToJson(Musketeer instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'cardImagePath': instance.cardImagePath,
      'characterImagePath': instance.characterImagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
      'slug': instance.slug,
      'remainingAbility': instance.remainingAbility,
      'hasRealGun': instance.hasRealGun,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
