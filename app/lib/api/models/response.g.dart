// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
      id: json['id'] as String,
      studentData:
          StudentData.fromJson(json['student_data'] as Map<String, dynamic>),
      graphOutput: json['graph_output'] as String,
    );

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'id': instance.id,
      'student_data': instance.studentData,
      'graph_output': instance.graphOutput,
    };
