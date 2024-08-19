// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentResponse _$StudentResponseFromJson(Map<String, dynamic> json) =>
    StudentResponse(
      student:
          CompetenciesStudent.fromJson(json['student'] as Map<String, dynamic>),
      comparisonList: (json['comparison_list'] as List<dynamic>)
          .map((e) => CompetenciesStudent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StudentResponseToJson(StudentResponse instance) =>
    <String, dynamic>{
      'student': instance.student,
      'comparison_list': instance.comparisonList,
    };
