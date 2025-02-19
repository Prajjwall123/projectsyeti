// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificationApiModel _$CertificationApiModelFromJson(
        Map<String, dynamic> json) =>
    CertificationApiModel(
      name: json['name'] as String,
      organization: json['organization'] as String,
    );

Map<String, dynamic> _$CertificationApiModelToJson(
        CertificationApiModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'organization': instance.organization,
    };
