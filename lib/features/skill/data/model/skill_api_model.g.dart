// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillApiModel _$SkillApiModelFromJson(Map<String, dynamic> json) =>
    SkillApiModel(
      skillId: json['_id'] as String?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SkillApiModelToJson(SkillApiModel instance) =>
    <String, dynamic>{
      '_id': instance.skillId,
      'name': instance.name,
    };
