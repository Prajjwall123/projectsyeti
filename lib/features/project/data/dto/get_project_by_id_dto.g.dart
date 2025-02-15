// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_project_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProjectByIdDTO _$GetProjectByIdDTOFromJson(Map<String, dynamic> json) =>
    GetProjectByIdDTO(
      projectId: json['projectId'] as String,
      title: json['title'] as String,
      companyId: json['companyId'] as String,
      companyName: json['companyName'] as String,
      companyLogo: json['companyLogo'] as String,
      category:
          (json['category'] as List<dynamic>).map((e) => e as String).toList(),
      requirements: json['requirements'] as String,
      headquarters: json['headquarters'] as String,
      description: json['description'] as String,
      duration: json['duration'] as String,
      postedDate: DateTime.parse(json['postedDate'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$GetProjectByIdDTOToJson(GetProjectByIdDTO instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'title': instance.title,
      'headquarters': instance.headquarters,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'companyLogo': instance.companyLogo,
      'category': instance.category,
      'requirements': instance.requirements,
      'description': instance.description,
      'duration': instance.duration,
      'postedDate': instance.postedDate.toIso8601String(),
      'status': instance.status,
    };
