// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExperienceApiModel _$ExperienceApiModelFromJson(Map<String, dynamic> json) =>
    ExperienceApiModel(
      title: json['title'] as String,
      company: json['company'] as String,
      from: (json['from'] as num).toInt(),
      to: (json['to'] as num).toInt(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$ExperienceApiModelToJson(ExperienceApiModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'company': instance.company,
      'from': instance.from,
      'to': instance.to,
      'description': instance.description,
    };
