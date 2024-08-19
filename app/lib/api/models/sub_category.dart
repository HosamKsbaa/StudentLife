// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'sub_category.g.dart';

@JsonSerializable()
class SubCategory {
  const SubCategory({
    required this.code,
    required this.name,
    required this.amount,
  });
  
  factory SubCategory.fromJson(Map<String, Object?> json) => _$SubCategoryFromJson(json);
  
  final String code;
  final String name;
  final num amount;

  Map<String, Object?> toJson() => _$SubCategoryToJson(this);
}
