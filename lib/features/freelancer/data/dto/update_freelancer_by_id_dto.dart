import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/certification/data/model/certification_api_model.dart';
import 'package:projectsyeti/features/experience/data/model/experience_api_model.dart';
import 'package:projectsyeti/features/skill/data/model/skill_api_model.dart';

part 'update_freelancer_by_id_dto.g.dart';

@JsonSerializable()
class UpdateFreelancerByIdDTO {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'skills')
  final List<SkillApiModel> skills;

  @JsonKey(name: 'experienceYears')
  final int experienceYears;

  @JsonKey(name: 'freelancerName')
  final String freelancerName;

  @JsonKey(name: 'availability')
  final String availability;

  @JsonKey(name: 'portfolio')
  final String portfolio;

  @JsonKey(name: 'profileImage')
  final String profileImage;

  @JsonKey(name: 'projectsCompleted')
  final int projectsCompleted;

  @JsonKey(name: 'certifications')
  final List<CertificationApiModel>? certifications;

  @JsonKey(name: 'experience')
  final List<ExperienceApiModel>? experience;

  @JsonKey(name: 'languages')
  final List<String>? languages;

  @JsonKey(name: 'profession')
  final String? profession;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'aboutMe')
  final String? aboutMe;

  @JsonKey(name: 'workAt')
  final String? workAt;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  UpdateFreelancerByIdDTO({
    required this.id,
    required this.skills,
    required this.experienceYears,
    required this.freelancerName,
    required this.availability,
    required this.portfolio,
    required this.profileImage,
    required this.projectsCompleted,
    this.certifications,
    this.experience,
    this.languages,
    this.profession,
    this.location,
    this.aboutMe,
    this.workAt,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to create DTO from JSON
  factory UpdateFreelancerByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdateFreelancerByIdDTOFromJson(json);

  // Method to convert DTO to JSON
  Map<String, dynamic> toJson() => _$UpdateFreelancerByIdDTOToJson(this);
}
