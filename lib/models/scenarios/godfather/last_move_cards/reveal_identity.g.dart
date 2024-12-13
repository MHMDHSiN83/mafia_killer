// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reveal_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RevealIdentity _$RevealIdentityFromJson(Map<String, dynamic> json) =>
    RevealIdentity()
      ..title = json['title'] as String
      ..description = json['description'] as String
      ..imagePath = json['imagePath'] as String
      ..flippedImagePath = json['flippedImagePath'] as String
      ..isUsed = json['isUsed'] as bool;

Map<String, dynamic> _$RevealIdentityToJson(RevealIdentity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'flippedImagePath': instance.flippedImagePath,
      'isUsed': instance.isUsed,
    };
