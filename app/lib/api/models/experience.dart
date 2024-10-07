// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

@JsonSerializable()
class Experience {
  const Experience({
    required this.title,
    required this.company,
    required this.location,
    required this.period,
  });
  
  factory Experience.fromJson(Map<String, Object?> json) => _$ExperienceFromJson(json);
  
  final String title;
  final String company;
  final String location;
  final String period;

  Map<String, Object?> toJson() => _$ExperienceToJson(this);
}
