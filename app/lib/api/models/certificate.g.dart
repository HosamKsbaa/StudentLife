// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Certificate _$CertificateFromJson(Map<String, dynamic> json) => Certificate(
      title: json['title'] as String,
      issuer: json['issuer'] as String,
      date: json['date'] as String,
      credentialId: json['credentialId'] as String,
    );

Map<String, dynamic> _$CertificateToJson(Certificate instance) =>
    <String, dynamic>{
      'title': instance.title,
      'issuer': instance.issuer,
      'date': instance.date,
      'credentialId': instance.credentialId,
    };
