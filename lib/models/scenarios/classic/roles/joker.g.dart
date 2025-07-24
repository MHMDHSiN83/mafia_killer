// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Joker _$JokerFromJson(Map<String, dynamic> json) => Joker()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..cardImagePath = json['cardImagePath'] as String
  ..characterImagePath = json['characterImagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide'])
  ..lastPlayerName = json['lastPlayerName'] as String?;

Map<String, dynamic> _$JokerToJson(Joker instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'cardImagePath': instance.cardImagePath,
      'characterImagePath': instance.characterImagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
      'lastPlayerName': instance.lastPlayerName,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
