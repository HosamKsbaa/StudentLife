// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'student_data.dart';

part 'response.g.dart';

@JsonSerializable()
class Response {
  const Response({
    required this.id,
    required this.studentData,
    required this.graphOutput,
  });
  
  factory Response.fromJson(Map<String, Object?> json) => _$ResponseFromJson(json);
  
  final String id;
  @JsonKey(name: 'student_data')
  final StudentData studentData;
  @JsonKey(name: 'graph_output')
  final String graphOutput;

  Map<String, Object?> toJson() => _$ResponseToJson(this);
}
