// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'hd_year.dart';
import 'student_level.dart';

part 'hd_student.g.dart';

@JsonSerializable()
class HDStudent {
  const HDStudent({
    required this.peopleId,
    required this.program,
    required this.degree,
    required this.curriculum,
    required this.college,
    required this.department,
    this.totalGpa = 0.0,
    this.totalCredits = 0,
    this.level = StudentLevel.freshman,
    this.years,
  });
  
  factory HDStudent.fromJson(Map<String, Object?> json) => _$HDStudentFromJson(json);
  
  @JsonKey(name: 'people_id')
  final int peopleId;
  final String program;
  final String degree;
  final String curriculum;
  final String college;
  final String department;
  final List<HDYear>? years;
  @JsonKey(name: 'total_gpa')
  final num totalGpa;
  @JsonKey(name: 'total_credits')
  final int totalCredits;
  final StudentLevel level;

  Map<String, Object?> toJson() => _$HDStudentToJson(this);
}
