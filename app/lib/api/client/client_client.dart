// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/hd_student.dart';
import '../models/ra_response.dart';
import '../models/student_response.dart';

part 'client_client.g.dart';

@RestApi()
abstract class ClientClient {
  factory ClientClient(Dio dio, {String? baseUrl}) = _ClientClient;

  /// Get Student
  @GET('/student/{student_id}/history')
  Future<HttpResponse<HDStudent>> getStudentStudentStudentIdHistoryGet({
    @Path('student_id') required int studentId,
    @Extras() Map<String, dynamic>? extras,
  });

  /// Get Student Progress
  @GET('/student/{student_id}/progress')
  Future<HttpResponse<String>> getStudentProgressStudentStudentIdProgressGet({
    @Path('student_id') required String studentId,
    @Extras() Map<String, dynamic>? extras,
  });

  /// Get Student Progress2
  @GET('/student/{student_id}/progress2')
  Future<HttpResponse<RAResponse>> getStudentProgress2StudentStudentIdProgress2Get({
    @Path('student_id') required String studentId,
    @Extras() Map<String, dynamic>? extras,
  });

  /// Read Student
  @GET('/student/{student_name}')
  Future<HttpResponse<StudentResponse>> readStudentStudentStudentNameGet({
    @Path('student_name') required String studentName,
    @Query('benchmarks') List<String>? benchmarks,
    @Extras() Map<String, dynamic>? extras,
  });
}
