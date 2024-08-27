// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'hd_course.g.dart';

@JsonSerializable()
class HDCourse {
  const HDCourse({
    required this.courseId,
    required this.courseName,
    required this.courseSection,
    required this.credit,
    this.finalGrade = 'N/A',
    this.gpa = 0.0,
  });
  
  factory HDCourse.fromJson(Map<String, Object?> json) => _$HDCourseFromJson(json);
  
  @JsonKey(name: 'course_id')
  final String courseId;
  @JsonKey(name: 'course_name')
  final String courseName;
  @JsonKey(name: 'course_section')
  final int courseSection;
  final int credit;
  @JsonKey(name: 'final_grade')
  final String finalGrade;
  final num gpa;

  Map<String, Object?> toJson() => _$HDCourseToJson(this);
}
