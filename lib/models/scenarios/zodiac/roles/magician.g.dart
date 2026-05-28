// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magician.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Magician _$MagicianFromJson(Map<String, dynamic> json) => Magician()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..cardImagePath = json['cardImagePath'] as String
  ..characterImagePath = json['characterImagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide'])
  ..slug = json['slug'] as String
  ..multiSelectionNumber = (json['multiSelectionNumber'] as num).toInt()
  ..lastPlayerName = json['lastPlayerName'] as String?;

Map<String, dynamic> _$MagicianToJson(Magician instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'cardImagePath': instance.cardImagePath,
      'characterImagePath': instance.characterImagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
      'slug': instance.slug,
      'multiSelectionNumber': instance.multiSelectionNumber,
      'lastPlayerName': instance.lastPlayerName,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
