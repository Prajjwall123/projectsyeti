// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_skill_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllSkillDTO _$GetAllSkillDTOFromJson(Map<String, dynamic> json) =>
    GetAllSkillDTO(
      skills: (json['skills'] as List<dynamic>)
          .map((e) => SkillApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllSkillDTOToJson(GetAllSkillDTO instance) =>
    <String, dynamic>{
      'skills': instance.skills,
    };
