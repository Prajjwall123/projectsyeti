// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectApiModel _$ProjectApiModelFromJson(Map<String, dynamic> json) =>
    ProjectApiModel(
      projectId: json['_id'] as String?,
      companyId: json['companyId'] as String,
      title: json['title'] as String,
      category: (json['category'] as List<dynamic>)
          .map((e) => SkillApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      requirements: json['requirements'] as String,
      description: json['description'] as String,
      duration: json['duration'] as String,
      postedDate: DateTime.parse(json['postedDate'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$ProjectApiModelToJson(ProjectApiModel instance) =>
    <String, dynamic>{
      '_id': instance.projectId,
      'companyId': instance.companyId,
      'title': instance.title,
      'category': instance.category,
      'requirements': instance.requirements,
      'description': instance.description,
      'duration': instance.duration,
      'postedDate': instance.postedDate.toIso8601String(),
      'status': instance.status,
    };
