// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_freelancer_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateFreelancerByIdDTO _$UpdateFreelancerByIdDTOFromJson(
        Map<String, dynamic> json) =>
    UpdateFreelancerByIdDTO(
      id: json['_id'] as String,
      skills: (json['skills'] as List<dynamic>)
          .map((e) => SkillApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      experienceYears: (json['experienceYears'] as num).toInt(),
      freelancerName: json['freelancerName'] as String,
      availability: json['availability'] as String,
      portfolio: json['portfolio'] as String,
      profileImage: json['profileImage'] as String,
      projectsCompleted: (json['projectsCompleted'] as num).toInt(),
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
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$UpdateFreelancerByIdDTOToJson(
        UpdateFreelancerByIdDTO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'skills': instance.skills,
      'experienceYears': instance.experienceYears,
      'freelancerName': instance.freelancerName,
      'availability': instance.availability,
      'portfolio': instance.portfolio,
      'profileImage': instance.profileImage,
      'projectsCompleted': instance.projectsCompleted,
      'certifications': instance.certifications,
      'experience': instance.experience,
      'languages': instance.languages,
      'profession': instance.profession,
      'location': instance.location,
      'aboutMe': instance.aboutMe,
      'workAt': instance.workAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
