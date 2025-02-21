import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/certification/data/model/certification_api_model.dart';
import 'package:projectsyeti/features/experience/data/model/experience_api_model.dart';
import 'package:projectsyeti/features/skill/data/model/skill_api_model.dart';

part 'freelancer_api_model.g.dart';

@JsonSerializable()
class FreelancerApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final List<SkillApiModel> skills;
  final int experienceYears;
  final String freelancerName;
  final String availability;
  final String portfolio;
  final String? profileImage;
  final int projectsCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<CertificationApiModel>? certifications;
  final List<ExperienceApiModel>? experience;
  final List<String>? languages;
  final String? profession;
  final String? location;
  final String? aboutMe;
  final String? workAt;
  @JsonKey(name: 'userId')
  final String userId;

  const FreelancerApiModel({
    this.id,
    required this.skills,
    required this.experienceYears,
    required this.freelancerName,
    required this.availability,
    required this.portfolio,
    this.profileImage,
    required this.projectsCompleted,
    this.createdAt,
    this.updatedAt,
    this.certifications,
    this.experience,
    this.languages,
    this.profession,
    this.location,
    this.aboutMe,
    this.workAt,
    required this.userId,
  });

  factory FreelancerApiModel.fromJson(Map<String, dynamic> json) =>
      _$FreelancerApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$FreelancerApiModelToJson(this);

  // ✅ Convert Model to Entity
  FreelancerEntity toEntity() {
    return FreelancerEntity(
      id: id ?? "",
      skills: skills.map((skill) => skill.toEntity()).toList(),
      experienceYears: experienceYears,
      freelancerName: freelancerName,
      availability: availability,
      portfolio: portfolio,
      profileImage: profileImage ?? "",
      projectsCompleted: projectsCompleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
      certifications: certifications?.map((cert) => cert.toEntity()).toList(),
      experience: experience?.map((exp) => exp.toEntity()).toList(),
      languages: languages,
      profession: profession,
      location: location,
      aboutMe: aboutMe,
      workAt: workAt,
      userId: userId,
    );
  }

  factory FreelancerApiModel.fromEntity(FreelancerEntity entity) {
    return FreelancerApiModel(
      id: entity.id,
      skills: entity.skills
          .map((skill) => SkillApiModel.fromEntity(skill))
          .toList(),
      experienceYears: entity.experienceYears,
      freelancerName: entity.freelancerName,
      availability: entity.availability,
      portfolio: entity.portfolio,
      profileImage: entity.profileImage,
      projectsCompleted: entity.projectsCompleted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      certifications: entity.certifications
          ?.map((cert) => CertificationApiModel.fromEntity(cert))
          .toList(),
      experience: entity.experience
          ?.map((exp) => ExperienceApiModel.fromEntity(exp))
          .toList(),
      languages: entity.languages,
      profession: entity.profession,
      location: entity.location,
      aboutMe: entity.aboutMe,
      workAt: entity.workAt,
      userId: entity.userId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        skills,
        experienceYears,
        freelancerName,
        availability,
        portfolio,
        profileImage,
        projectsCompleted,
        createdAt,
        updatedAt,
        certifications,
        experience,
        languages,
        profession,
        location,
        aboutMe,
        workAt,
        userId,
      ];
}
