// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'x_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XProfile _$XProfileFromJson(Map<String, dynamic> json) => XProfile(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      currentSemester: (json['currentSemester'] as num).toInt(),
      enrolledCourses: (json['enrolledCourses'] as num).toInt(),
      completedCourses: (json['completedCourses'] as num).toInt(),
      coursesInProgress: (json['coursesInProgress'] as num).toInt(),
      skills: (json['skills'] as List<dynamic>)
          .map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList(),
      experiences: (json['experiences'] as List<dynamic>)
          .map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
      certificates: (json['certificates'] as List<dynamic>)
          .map((e) => Certificate.fromJson(e as Map<String, dynamic>))
          .toList(),
      major: json['major'] as String? ?? 'Computer Science',
      department:
          json['department'] as String? ?? 'Computer Science Department',
    );

Map<String, dynamic> _$XProfileToJson(XProfile instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'password': instance.password,
      'major': instance.major,
      'department': instance.department,
      'currentSemester': instance.currentSemester,
      'enrolledCourses': instance.enrolledCourses,
      'completedCourses': instance.completedCourses,
      'coursesInProgress': instance.coursesInProgress,
      'skills': instance.skills,
      'experiences': instance.experiences,
      'certificates': instance.certificates,
    };
