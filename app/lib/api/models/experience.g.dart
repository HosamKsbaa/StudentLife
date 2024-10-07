// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
      title: json['title'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      period: json['period'] as String,
    );

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'title': instance.title,
      'company': instance.company,
      'location': instance.location,
      'period': instance.period,
    };
