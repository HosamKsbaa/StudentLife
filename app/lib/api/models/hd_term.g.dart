// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hd_term.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HDTerm _$HDTermFromJson(Map<String, dynamic> json) => HDTerm(
      termName: json['term_name'] as String,
      termGpa: json['term_gpa'] as num? ?? 0.0,
      totalCredits: (json['total_credits'] as num?)?.toInt() ?? 0,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => HDCourse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HDTermToJson(HDTerm instance) => <String, dynamic>{
      'term_name': instance.termName,
      'courses': instance.courses,
      'term_gpa': instance.termGpa,
      'total_credits': instance.totalCredits,
    };
