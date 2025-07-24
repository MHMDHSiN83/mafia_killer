// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'handcuffs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Handcuffs _$HandcuffsFromJson(Map<String, dynamic> json) => Handcuffs()
  ..title = json['title'] as String
  ..description = json['description'] as String
  ..imagePath = json['imagePath'] as String
  ..flippedImagePath = json['flippedImagePath'] as String
  ..selectionImagePath = json['selectionImagePath'] as String
  ..isUsed = json['isUsed'] as bool
  ..slug = json['slug'] as String;

Map<String, dynamic> _$HandcuffsToJson(Handcuffs instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'flippedImagePath': instance.flippedImagePath,
      'selectionImagePath': instance.selectionImagePath,
      'isUsed': instance.isUsed,
      'slug': instance.slug,
    };
