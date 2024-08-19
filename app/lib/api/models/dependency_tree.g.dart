// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependency_tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DependencyTree _$DependencyTreeFromJson(Map<String, dynamic> json) =>
    DependencyTree(
      code: json['code'] as String,
      name: json['name'] as String,
      typicalYear: (json['typical_year'] as num).toInt(),
      term: (json['term'] as num).toInt(),
      category: json['category'] as String,
      credits: (json['credits'] as num).toInt(),
      dependencies: (json['dependencies'] as List<dynamic>?)
          ?.map((e) => DependencyTree.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DependencyTreeToJson(DependencyTree instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'typical_year': instance.typicalYear,
      'term': instance.term,
      'category': instance.category,
      'credits': instance.credits,
      'dependencies': instance.dependencies,
    };
