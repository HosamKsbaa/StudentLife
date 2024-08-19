// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'sub_category.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  const Category({
    required this.code,
    required this.name,
    required this.amount,
    required this.subCategories,
  });
  
  factory Category.fromJson(Map<String, Object?> json) => _$CategoryFromJson(json);
  
  final String code;
  final String name;
  final num amount;
  @JsonKey(name: 'sub_categories')
  final List<SubCategory> subCategories;

  Map<String, Object?> toJson() => _$CategoryToJson(this);
}
