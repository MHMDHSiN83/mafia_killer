// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mafia.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mafia _$MafiaFromJson(Map<String, dynamic> json) => Mafia()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..imagePath = json['imagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide']);

Map<String, dynamic> _$MafiaToJson(Mafia instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
