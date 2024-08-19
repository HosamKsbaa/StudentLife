// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'dependency_tree.dart';

part 'dependency_tree.g.dart';

@JsonSerializable()
class DependencyTree {
  const DependencyTree({
    required this.code,
    required this.name,
    required this.typicalYear,
    required this.term,
    required this.category,
    required this.credits,
    this.dependencies,
  });
  
  factory DependencyTree.fromJson(Map<String, Object?> json) => _$DependencyTreeFromJson(json);
  
  final String code;
  final String name;
  @JsonKey(name: 'typical_year')
  final int typicalYear;
  final int term;
  final String category;
  final int credits;
  final List<DependencyTree>? dependencies;

  Map<String, Object?> toJson() => _$DependencyTreeToJson(this);
}
