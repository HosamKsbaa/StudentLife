// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ra_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RAResponse _$RAResponseFromJson(Map<String, dynamic> json) => RAResponse(
      id: json['id'] as String,
      studentData:
          StudentData.fromJson(json['student_data'] as Map<String, dynamic>),
      graphOutput: json['graph_output'] as String,
    );

Map<String, dynamic> _$RAResponseToJson(RAResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'student_data': instance.studentData,
      'graph_output': instance.graphOutput,
    };
