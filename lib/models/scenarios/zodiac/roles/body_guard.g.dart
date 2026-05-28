// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_guard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyGuard _$BodyGuardFromJson(Map<String, dynamic> json) => BodyGuard()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..cardImagePath = json['cardImagePath'] as String
  ..characterImagePath = json['characterImagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide'])
  ..slug = json['slug'] as String;

Map<String, dynamic> _$BodyGuardToJson(BodyGuard instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'cardImagePath': instance.cardImagePath,
      'characterImagePath': instance.characterImagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
      'slug': instance.slug,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
