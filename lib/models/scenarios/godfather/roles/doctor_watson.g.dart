// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_watson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorWatson _$DoctorWatsonFromJson(Map<String, dynamic> json) => DoctorWatson()
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..imagePath = json['imagePath'] as String
  ..roleSide = $enumDecode(_$RoleSideEnumMap, json['roleSide'])
  ..selfHeal = (json['selfHeal'] as num).toInt();

Map<String, dynamic> _$DoctorWatsonToJson(DoctorWatson instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'roleSide': _$RoleSideEnumMap[instance.roleSide]!,
      'selfHeal': instance.selfHeal,
    };

const _$RoleSideEnumMap = {
  RoleSide.mafia: 'mafia',
  RoleSide.citizen: 'citizen',
  RoleSide.independant: 'independant',
};
