// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'course_info.dart';
import 'ineligible_course.dart';

part 'student_data.g.dart';

@JsonSerializable()
class StudentData {
  const StudentData({
    required this.eligibleCourses,
    required this.ineligibleCourses,
    required this.categoryProgress,
  });
  
  factory StudentData.fromJson(Map<String, Object?> json) => _$StudentDataFromJson(json);
  
  @JsonKey(name: 'eligible_courses')
  final Map<String, List<CourseInfo>> eligibleCourses;
  @JsonKey(name: 'ineligible_courses')
  final Map<String, List<IneligibleCourse>> ineligibleCourses;
  @JsonKey(name: 'category_progress')
  final Map<String, Map<String, int>> categoryProgress;

  Map<String, Object?> toJson() => _$StudentDataToJson(this);
}
