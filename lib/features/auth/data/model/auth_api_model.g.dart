// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      freelancerName: json['freelancerName'] as String,
      portfolio: json['portfolio'] as String?,
      profileImage: json['profileImage'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
      skills: (json['skills'] as List<dynamic>)
          .map((e) => SkillApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      availability: json['availability'] as String?,
      experienceYears: (json['experienceYears'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'freelancerName': instance.freelancerName,
      'profileImage': instance.profileImage,
      'skills': instance.skills,
      'email': instance.email,
      'password': instance.password,
      'portfolio': instance.portfolio,
      'availability': instance.availability,
      'experienceYears': instance.experienceYears,
    };
