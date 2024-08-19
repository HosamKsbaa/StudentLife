// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'dependency_tree.dart';

part 'course_info.g.dart';

@JsonSerializable()
class CourseInfo {
  const CourseInfo({
    required this.code,
    required this.name,
    required this.originalCode,
    required this.credits,
    required this.expectedGrade,
    required this.category,
    required this.isAvailableThisTerm,
    required this.typicalYear,
    required this.term,
    required this.categoryProgress,
    required this.dependentCoursesCount,
    required this.dependencyTree,
  });
  
  factory CourseInfo.fromJson(Map<String, Object?> json) => _$CourseInfoFromJson(json);
  
  final String code;
  final String name;
  final String originalCode;
  final int credits;
  final num expectedGrade;
  final String category;
  @JsonKey(name: 'is_available_this_term')
  final bool isAvailableThisTerm;
  @JsonKey(name: 'typical_year')
  final int typicalYear;
  final int term;
  @JsonKey(name: 'category_progress')
  final String categoryProgress;
  @JsonKey(name: 'dependent_courses_count')
  final int dependentCoursesCount;
  @JsonKey(name: 'dependency_tree')
  final DependencyTree dependencyTree;

  Map<String, Object?> toJson() => _$CourseInfoToJson(this);
}
