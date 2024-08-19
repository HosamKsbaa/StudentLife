// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'competencies_student.dart';

part 'student_response.g.dart';

@JsonSerializable()
class StudentResponse {
  const StudentResponse({
    required this.student,
    required this.comparisonList,
  });
  
  factory StudentResponse.fromJson(Map<String, Object?> json) => _$StudentResponseFromJson(json);
  
  final CompetenciesStudent student;
  @JsonKey(name: 'comparison_list')
  final List<CompetenciesStudent> comparisonList;

  Map<String, Object?> toJson() => _$StudentResponseToJson(this);
}
