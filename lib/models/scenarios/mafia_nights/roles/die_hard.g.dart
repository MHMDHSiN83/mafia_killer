// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'die_hard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DieHard _$DieHardFromJson(Map<String, dynamic> json) => DieHard()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..cardImagePath = json['cardImagePath'] as String
  ..characterImagePath = json['characterImagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide'])
  ..slug = json['slug'] as String
  ..shield = (json['shield'] as num).toInt();

Map<String, dynamic> _$DieHardToJson(DieHard instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'cardImagePath': instance.cardImagePath,
      'characterImagePath': instance.characterImagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
      'slug': instance.slug,
      'shield': instance.shield,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
