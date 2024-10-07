// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'ra_response.dart';
import 'x_profile.dart';

part 'student_states.g.dart';

@JsonSerializable()
class StudentStates {
  const StudentStates({
    required this.profile,
    required this.progress,
  });
  
  factory StudentStates.fromJson(Map<String, Object?> json) => _$StudentStatesFromJson(json);
  
  final XProfile profile;
  final RAResponse progress;

  Map<String, Object?> toJson() => _$StudentStatesToJson(this);
}
