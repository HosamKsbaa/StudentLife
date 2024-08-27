// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hd_year.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HDYear _$HDYearFromJson(Map<String, dynamic> json) => HDYear(
      year: (json['year'] as num).toInt(),
      yearGpa: json['year_gpa'] as num? ?? 0.0,
      totalCredits: (json['total_credits'] as num?)?.toInt() ?? 0,
      terms: (json['terms'] as List<dynamic>?)
          ?.map((e) => HDTerm.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HDYearToJson(HDYear instance) => <String, dynamic>{
      'year': instance.year,
      'terms': instance.terms,
      'year_gpa': instance.yearGpa,
      'total_credits': instance.totalCredits,
    };
