// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'hd_course.dart';

part 'hd_term.g.dart';

@JsonSerializable()
class HDTerm {
  const HDTerm({
    required this.termName,
    this.termGpa = 0.0,
    this.totalCredits = 0,
    this.courses,
  });
  
  factory HDTerm.fromJson(Map<String, Object?> json) => _$HDTermFromJson(json);
  
  @JsonKey(name: 'term_name')
  final String termName;
  final List<HDCourse>? courses;
  @JsonKey(name: 'term_gpa')
  final num termGpa;
  @JsonKey(name: 'total_credits')
  final int totalCredits;

  Map<String, Object?> toJson() => _$HDTermToJson(this);
}
