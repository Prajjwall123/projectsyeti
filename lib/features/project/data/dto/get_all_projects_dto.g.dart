// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_projects_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllProjectsDTO _$GetAllProjectsDTOFromJson(Map<String, dynamic> json) =>
    GetAllProjectsDTO(
      projectId: json['projectId'] as String,
      title: json['title'] as String,
      companyId: json['companyId'] as String,
      companyName: json['companyName'] as String,
      headquarters: json['headquarters'] as String,
      companyLogo: json['companyLogo'] as String,
      category:
          (json['category'] as List<dynamic>).map((e) => e as String).toList(),
      requirements: json['requirements'] as String,
      description: json['description'] as String,
      duration: json['duration'] as String,
      postedDate: DateTime.parse(json['postedDate'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$GetAllProjectsDTOToJson(GetAllProjectsDTO instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'title': instance.title,
      'companyId': instance.companyId,
      'headquarters': instance.headquarters,
      'companyName': instance.companyName,
      'companyLogo': instance.companyLogo,
      'category': instance.category,
      'requirements': instance.requirements,
      'description': instance.description,
      'duration': instance.duration,
      'postedDate': instance.postedDate.toIso8601String(),
      'status': instance.status,
    };
