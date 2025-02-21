// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freelancer_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreelancerApiModel _$FreelancerApiModelFromJson(Map<String, dynamic> json) =>
    FreelancerApiModel(
      id: json['_id'] as String?,
      skills: (json['skills'] as List<dynamic>)
          .map((e) => SkillApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      experienceYears: (json['experienceYears'] as num).toInt(),
      freelancerName: json['freelancerName'] as String,
      availability: json['availability'] as String,
      portfolio: json['portfolio'] as String,
      profileImage: json['profileImage'] as String?,
      projectsCompleted: (json['projectsCompleted'] as num).toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      certifications: (json['certifications'] as List<dynamic>?)
          ?.map(
              (e) => CertificationApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      experience: (json['experience'] as List<dynamic>?)
          ?.map((e) => ExperienceApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profession: json['profession'] as String?,
      location: json['location'] as String?,
      aboutMe: json['aboutMe'] as String?,
      workAt: json['workAt'] as String?,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$FreelancerApiModelToJson(FreelancerApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'skills': instance.skills,
      'experienceYears': instance.experienceYears,
      'freelancerName': instance.freelancerName,
      'availability': instance.availability,
      'portfolio': instance.portfolio,
      'profileImage': instance.profileImage,
      'projectsCompleted': instance.projectsCompleted,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'certifications': instance.certifications,
      'experience': instance.experience,
      'languages': instance.languages,
      'profession': instance.profession,
      'location': instance.location,
      'aboutMe': instance.aboutMe,
      'workAt': instance.workAt,
      'userId': instance.userId,
    };
