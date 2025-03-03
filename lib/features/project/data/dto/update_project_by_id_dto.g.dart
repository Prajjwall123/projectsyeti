// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_project_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProjectByIdDTO _$UpdateProjectByIdDTOFromJson(
        Map<String, dynamic> json) =>
    UpdateProjectByIdDTO(
      projectId: json['_id'] as String,
      title: json['title'] as String?,
      companyId: json['company'] as String?,
      companyName: json['companyName'] as String?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      requirements: json['requirements'] as String?,
      description: json['description'] as String?,
      duration: json['duration'] as String?,
      postedDate: json['postedDate'] == null
          ? null
          : DateTime.parse(json['postedDate'] as String),
      status: json['status'] as String?,
      awardedTo: json['awardedTo'] as String?,
      feedbackRequestedMessage: json['feedbackRequestedMessage'] as String?,
      feedbackRespondMessage: json['feedbackRespondMessage'] as String?,
      link: json['link'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UpdateProjectByIdDTOToJson(
        UpdateProjectByIdDTO instance) =>
    <String, dynamic>{
      '_id': instance.projectId,
      'title': instance.title,
      'company': instance.companyId,
      'companyName': instance.companyName,
      'category': instance.category,
      'requirements': instance.requirements,
      'description': instance.description,
      'duration': instance.duration,
      'postedDate': instance.postedDate?.toIso8601String(),
      'status': instance.status,
      'awardedTo': instance.awardedTo,
      'feedbackRequestedMessage': instance.feedbackRequestedMessage,
      'feedbackRespondMessage': instance.feedbackRespondMessage,
      'link': instance.link,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
