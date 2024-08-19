// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competencies_student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompetenciesStudent _$CompetenciesStudentFromJson(Map<String, dynamic> json) =>
    CompetenciesStudent(
      name: json['name'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompetenciesStudentToJson(
        CompetenciesStudent instance) =>
    <String, dynamic>{
      'name': instance.name,
      'categories': instance.categories,
    };
