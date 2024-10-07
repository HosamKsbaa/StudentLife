// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'certificate.dart';
import 'experience.dart';
import 'skill.dart';

part 'x_profile.g.dart';

@JsonSerializable()
class XProfile {
  const XProfile({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.currentSemester,
    required this.enrolledCourses,
    required this.completedCourses,
    required this.coursesInProgress,
    required this.skills,
    required this.experiences,
    required this.certificates,
    this.major = 'Computer Science',
    this.department = 'Computer Science Department',
  });
  
  factory XProfile.fromJson(Map<String, Object?> json) => _$XProfileFromJson(json);
  
  final String id;
  final String email;
  final String name;
  final String password;
  final String major;
  final String department;
  final int currentSemester;
  final int enrolledCourses;
  final int completedCourses;
  final int coursesInProgress;
  final List<Skill> skills;
  final List<Experience> experiences;
  final List<Certificate> certificates;

  Map<String, Object?> toJson() => _$XProfileToJson(this);
}
