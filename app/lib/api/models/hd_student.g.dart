// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hd_student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HDStudent _$HDStudentFromJson(Map<String, dynamic> json) => HDStudent(
      peopleId: (json['people_id'] as num).toInt(),
      program: json['program'] as String,
      degree: json['degree'] as String,
      curriculum: json['curriculum'] as String,
      college: json['college'] as String,
      department: json['department'] as String,
      totalGpa: json['total_gpa'] as num? ?? 0.0,
      totalCredits: (json['total_credits'] as num?)?.toInt() ?? 0,
      level: json['level'] == null
          ? StudentLevel.freshman
          : StudentLevel.fromJson(json['level'] as String),
      years: (json['years'] as List<dynamic>?)
          ?.map((e) => HDYear.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HDStudentToJson(HDStudent instance) => <String, dynamic>{
      'people_id': instance.peopleId,
      'program': instance.program,
      'degree': instance.degree,
      'curriculum': instance.curriculum,
      'college': instance.college,
      'department': instance.department,
      'years': instance.years,
      'total_gpa': instance.totalGpa,
      'total_credits': instance.totalCredits,
      'level': instance.level,
    };
