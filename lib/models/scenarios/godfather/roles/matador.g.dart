// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matador.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Matador _$MatadorFromJson(Map<String, dynamic> json) => Matador()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..cardImagePath = json['cardImagePath'] as String
  ..characterImagePath = json['characterImagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide'])
  ..multiSelectionNumber = (json['multiSelectionNumber'] as num).toInt()
  ..lastPlayerName = json['lastPlayerName'] as String?;

Map<String, dynamic> _$MatadorToJson(Matador instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'cardImagePath': instance.cardImagePath,
      'characterImagePath': instance.characterImagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
      'multiSelectionNumber': instance.multiSelectionNumber,
      'lastPlayerName': instance.lastPlayerName,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
