// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameSettings _$GameSettingsFromJson(Map<String, dynamic> json) => GameSettings()
  ..introTime = (json['introTime'] as num).toInt()
  ..mainSpeakTime = (json['mainSpeakTime'] as num).toInt()
  ..inquiry = (json['inquiry'] as num).toInt()
  ..narrator = json['narrator'] as String
  ..playMusic = json['playMusic'] as bool
  ..soundEffect = json['soundEffect'] as bool
  ..narrators =
      (json['narrators'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$GameSettingsToJson(GameSettings instance) =>
    <String, dynamic>{
      'introTime': instance.introTime,
      'mainSpeakTime': instance.mainSpeakTime,
      'inquiry': instance.inquiry,
      'narrator': instance.narrator,
      'playMusic': instance.playMusic,
      'soundEffect': instance.soundEffect,
      'narrators': instance.narrators,
    };
