// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beautiful_mind.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeautifulMind _$BeautifulMindFromJson(Map<String, dynamic> json) =>
    BeautifulMind()
      ..title = json['title'] as String
      ..description = json['description'] as String
      ..imagePath = json['imagePath'] as String
      ..flippedImagePath = json['flippedImagePath'] as String;

Map<String, dynamic> _$BeautifulMindToJson(BeautifulMind instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'flippedImagePath': instance.flippedImagePath,
    };
