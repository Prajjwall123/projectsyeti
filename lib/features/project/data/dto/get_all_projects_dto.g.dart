// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_projects_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllProjectsDTO _$GetAllProjectsDTOFromJson(Map<String, dynamic> json) =>
    GetAllProjectsDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => ProjectApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllProjectsDTOToJson(GetAllProjectsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
