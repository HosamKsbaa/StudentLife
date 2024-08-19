// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'category.dart';

part 'competencies_student.g.dart';

@JsonSerializable()
class CompetenciesStudent {
  const CompetenciesStudent({
    required this.name,
    required this.categories,
  });
  
  factory CompetenciesStudent.fromJson(Map<String, Object?> json) => _$CompetenciesStudentFromJson(json);
  
  final String name;
  final List<Category> categories;

  Map<String, Object?> toJson() => _$CompetenciesStudentToJson(this);
}
