// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_states.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentStates _$StudentStatesFromJson(Map<String, dynamic> json) =>
    StudentStates(
      profile: XProfile.fromJson(json['profile'] as Map<String, dynamic>),
      progress: RAResponse.fromJson(json['progress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StudentStatesToJson(StudentStates instance) =>
    <String, dynamic>{
      'profile': instance.profile,
      'progress': instance.progress,
    };
