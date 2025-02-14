// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_project_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProjectByIdDTO _$GetProjectByIdDTOFromJson(Map<String, dynamic> json) =>
    GetProjectByIdDTO(
      projectId: json['_id'] as String,
      data: ProjectApiModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetProjectByIdDTOToJson(GetProjectByIdDTO instance) =>
    <String, dynamic>{
      '_id': instance.projectId,
      'data': instance.data,
    };
