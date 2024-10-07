// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hd_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HDCourse _$HDCourseFromJson(Map<String, dynamic> json) => HDCourse(
      courseId: json['course_id'] as String,
      courseName: json['course_name'] as String,
      courseSection: (json['course_section'] as num).toInt(),
      credit: json['credit'] as num,
      finalGrade: json['final_grade'] as String? ?? 'N/A',
      gpa: json['gpa'] as num? ?? 0.0,
    );

Map<String, dynamic> _$HDCourseToJson(HDCourse instance) => <String, dynamic>{
      'course_id': instance.courseId,
      'course_name': instance.courseName,
      'course_section': instance.courseSection,
      'credit': instance.credit,
      'final_grade': instance.finalGrade,
      'gpa': instance.gpa,
    };
