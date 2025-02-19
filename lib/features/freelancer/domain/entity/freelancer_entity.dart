import 'package:equatable/equatable.dart';
import 'package:projectsyeti/features/certification/domain/entity/certification_entity.dart';
import 'package:projectsyeti/features/experience/domain/entity/experience_entity.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

class FreelancerEntity extends Equatable {
  final String id;
  final List<SkillEntity> skills;
  final int experienceYears;
  final String freelancerName;
  final String availability;
  final String portfolio;
  final String profileImage;
  final int projectsCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CertificationEntity> certifications;
  final List<ExperienceEntity> experience;
  final List<String> languages;
  final String profession;
  final String location;
  final String aboutMe;
  final String workAt;
  final String userId;

  const FreelancerEntity({
    required this.id,
    required this.skills,
    required this.experienceYears,
    required this.freelancerName,
    required this.availability,
    required this.portfolio,
    required this.profileImage,
    required this.projectsCompleted,
    required this.createdAt,
    required this.updatedAt,
    required this.certifications,
    required this.experience,
    required this.languages,
    required this.profession,
    required this.location,
    required this.aboutMe,
    required this.workAt,
    required this.userId,
  });

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

  FreelancerEntity copyWith({
    String? id,
    List<SkillEntity>? skills,
    int? experienceYears,
    String? freelancerName,
    String? availability,
    String? portfolio,
    String? profileImage,
    int? projectsCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CertificationEntity>? certifications,
    List<ExperienceEntity>? experience,
    List<String>? languages,
    String? profession,
    String? location,
    String? aboutMe,
    String? workAt,
    String? userId,
  }) {
    return FreelancerEntity(
      id: id ?? this.id,
      skills: skills ?? this.skills,
      experienceYears: experienceYears ?? this.experienceYears,
      freelancerName: freelancerName ?? this.freelancerName,
      availability: availability ?? this.availability,
      portfolio: portfolio ?? this.portfolio,
      profileImage: profileImage ?? this.profileImage,
      projectsCompleted: projectsCompleted ?? this.projectsCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      certifications: certifications ?? this.certifications,
      experience: experience ?? this.experience,
      languages: languages ?? this.languages,
      profession: profession ?? this.profession,
      location: location ?? this.location,
      aboutMe: aboutMe ?? this.aboutMe,
      workAt: workAt ?? this.workAt,
      userId: userId ?? this.userId,
    );
  }
}
