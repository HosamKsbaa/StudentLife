// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'certificate.g.dart';

@JsonSerializable()
class Certificate {
  const Certificate({
    required this.title,
    required this.issuer,
    required this.date,
    required this.credentialId,
  });
  
  factory Certificate.fromJson(Map<String, Object?> json) => _$CertificateFromJson(json);
  
  final String title;
  final String issuer;
  final String date;
  final String credentialId;

  Map<String, Object?> toJson() => _$CertificateToJson(this);
}
