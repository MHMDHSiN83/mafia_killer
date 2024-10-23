// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leon _$LeonFromJson(Map<String, dynamic> json) => Leon()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..imagePath = json['imagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide'])
  ..remainingAbility = (json['remainingAbility'] as num).toInt();

Map<String, dynamic> _$LeonToJson(Leon instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
      'remainingAbility': instance.remainingAbility,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
