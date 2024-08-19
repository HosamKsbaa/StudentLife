// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'course_info.dart';

part 'ineligible_course.g.dart';

@JsonSerializable()
class IneligibleCourse {
  const IneligibleCourse({
    required this.course,
    required this.reasons,
  });
  
  factory IneligibleCourse.fromJson(Map<String, Object?> json) => _$IneligibleCourseFromJson(json);
  
  final CourseInfo course;
  final List<String> reasons;

  Map<String, Object?> toJson() => _$IneligibleCourseToJson(this);
}
