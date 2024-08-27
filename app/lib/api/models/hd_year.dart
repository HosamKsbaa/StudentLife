// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'hd_term.dart';

part 'hd_year.g.dart';

@JsonSerializable()
class HDYear {
  const HDYear({
    required this.year,
    this.yearGpa = 0.0,
    this.totalCredits = 0,
    this.terms,
  });
  
  factory HDYear.fromJson(Map<String, Object?> json) => _$HDYearFromJson(json);
  
  final int year;
  final List<HDTerm>? terms;
  @JsonKey(name: 'year_gpa')
  final num yearGpa;
  @JsonKey(name: 'total_credits')
  final int totalCredits;

  Map<String, Object?> toJson() => _$HDYearToJson(this);
}
