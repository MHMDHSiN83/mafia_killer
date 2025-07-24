// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_lecter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorLecter _$DoctorLecterFromJson(Map<String, dynamic> json) => DoctorLecter()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..cardImagePath = json['cardImagePath'] as String
  ..characterImagePath = json['characterImagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide'])
  ..selfHeal = (json['selfHeal'] as num).toInt();

Map<String, dynamic> _$DoctorLecterToJson(DoctorLecter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'cardImagePath': instance.cardImagePath,
      'characterImagePath': instance.characterImagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
      'selfHeal': instance.selfHeal,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
