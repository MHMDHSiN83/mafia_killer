// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constantine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Constantine _$ConstantineFromJson(Map<String, dynamic> json) => Constantine()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..cardImagePath = json['cardImagePath'] as String
  ..characterImagePath = json['characterImagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide'])
  ..slug = json['slug'] as String
  ..remainingAbility = (json['remainingAbility'] as num).toInt();

Map<String, dynamic> _$ConstantineToJson(Constantine instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'cardImagePath': instance.cardImagePath,
      'characterImagePath': instance.characterImagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
      'slug': instance.slug,
      'remainingAbility': instance.remainingAbility,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
