// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'student_data.dart';

part 'ra_response.g.dart';

@JsonSerializable()
class RAResponse {
  const RAResponse({
    required this.id,
    required this.studentData,
    required this.graphOutput,
  });
  
  factory RAResponse.fromJson(Map<String, Object?> json) => _$RAResponseFromJson(json);
  
  final String id;
  @JsonKey(name: 'student_data')
  final StudentData studentData;
  @JsonKey(name: 'graph_output')
  final String graphOutput;

  Map<String, Object?> toJson() => _$RAResponseToJson(this);
}
