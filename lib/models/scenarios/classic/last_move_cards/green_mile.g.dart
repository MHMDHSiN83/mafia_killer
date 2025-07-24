// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'green_mile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GreenMile _$GreenMileFromJson(Map<String, dynamic> json) => GreenMile()
  ..title = json['title'] as String
  ..description = json['description'] as String
  ..imagePath = json['imagePath'] as String
  ..flippedImagePath = json['flippedImagePath'] as String
  ..selectionImagePath = json['selectionImagePath'] as String
  ..isUsed = json['isUsed'] as bool;

Map<String, dynamic> _$GreenMileToJson(GreenMile instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'flippedImagePath': instance.flippedImagePath,
      'selectionImagePath': instance.selectionImagePath,
      'isUsed': instance.isUsed,
    };
