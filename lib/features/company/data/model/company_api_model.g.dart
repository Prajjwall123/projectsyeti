// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyApiModel _$CompanyApiModelFromJson(Map<String, dynamic> json) =>
    CompanyApiModel(
      id: json['_id'] as String?,
      companyName: json['companyName'] as String,
      companyBio: json['companyBio'] as String?,
      employees: (json['employees'] as num).toInt(),
      logo: json['logo'] as String?,
      projectsPosted: (json['projectsPosted'] as num).toInt(),
      projectsAwarded: (json['projectsAwarded'] as num).toInt(),
      projectsCompleted: (json['projectsCompleted'] as num).toInt(),
      founded: (json['founded'] as num?)?.toInt(),
      ceo: json['ceo'] as String?,
      headquarters: json['headquarters'] as String?,
      industry: json['industry'] as String?,
      website: json['website'] as String?,
    );

Map<String, dynamic> _$CompanyApiModelToJson(CompanyApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'companyName': instance.companyName,
      'companyBio': instance.companyBio,
      'employees': instance.employees,
      'logo': instance.logo,
      'projectsPosted': instance.projectsPosted,
      'projectsAwarded': instance.projectsAwarded,
      'projectsCompleted': instance.projectsCompleted,
      'founded': instance.founded,
      'ceo': instance.ceo,
      'headquarters': instance.headquarters,
      'industry': instance.industry,
      'website': instance.website,
    };
