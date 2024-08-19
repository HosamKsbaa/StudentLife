// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ineligible_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IneligibleCourse _$IneligibleCourseFromJson(Map<String, dynamic> json) =>
    IneligibleCourse(
      course: CourseInfo.fromJson(json['course'] as Map<String, dynamic>),
      reasons:
          (json['reasons'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$IneligibleCourseToJson(IneligibleCourse instance) =>
    <String, dynamic>{
      'course': instance.course,
      'reasons': instance.reasons,
    };
