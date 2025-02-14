// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_skill_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSkillByIdDTO _$GetSkillByIdDTOFromJson(Map<String, dynamic> json) =>
    GetSkillByIdDTO(
      skill: SkillApiModel.fromJson(json['skill'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetSkillByIdDTOToJson(GetSkillByIdDTO instance) =>
    <String, dynamic>{
      'skill': instance.skill,
    };
