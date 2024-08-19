// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentData _$StudentDataFromJson(Map<String, dynamic> json) => StudentData(
      eligibleCourses: (json['eligible_courses'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => CourseInfo.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      ineligibleCourses:
          (json['ineligible_courses'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map(
                    (e) => IneligibleCourse.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      categoryProgress: (json['category_progress'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Map<String, int>.from(e as Map)),
      ),
    );

Map<String, dynamic> _$StudentDataToJson(StudentData instance) =>
    <String, dynamic>{
      'eligible_courses': instance.eligibleCourses,
      'ineligible_courses': instance.ineligibleCourses,
      'category_progress': instance.categoryProgress,
    };
