// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseInfo _$CourseInfoFromJson(Map<String, dynamic> json) => CourseInfo(
      code: json['code'] as String,
      name: json['name'] as String,
      originalCode: json['originalCode'] as String,
      credits: (json['credits'] as num).toInt(),
      expectedGrade: json['expectedGrade'] as num,
      category: json['category'] as String,
      isAvailableThisTerm: json['is_available_this_term'] as bool,
      typicalYear: (json['typical_year'] as num).toInt(),
      term: (json['term'] as num).toInt(),
      categoryProgress: json['category_progress'] as String,
      dependentCoursesCount: (json['dependent_courses_count'] as num).toInt(),
      dependencyTree: DependencyTree.fromJson(
          json['dependency_tree'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseInfoToJson(CourseInfo instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'originalCode': instance.originalCode,
      'credits': instance.credits,
      'expectedGrade': instance.expectedGrade,
      'category': instance.category,
      'is_available_this_term': instance.isAvailableThisTerm,
      'typical_year': instance.typicalYear,
      'term': instance.term,
      'category_progress': instance.categoryProgress,
      'dependent_courses_count': instance.dependentCoursesCount,
      'dependency_tree': instance.dependencyTree,
    };
