// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';

@JsonSerializable()
class Skill {
  const Skill({
    required this.name,
    required this.score,
  });
  
  factory Skill.fromJson(Map<String, Object?> json) => _$SkillFromJson(json);
  
  final String name;
  final int score;

  Map<String, Object?> toJson() => _$SkillToJson(this);
}
