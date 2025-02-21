import 'package:equatable/equatable.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String freelancerName;
  final String? profileImage;
  final List<SkillEntity> skills;
  final String email;
  final String password;
  final String portfolio;
  final String availability;
  final int experienceYears;

  const AuthEntity({
    this.userId,
    required this.freelancerName,
    required this.portfolio,
    this.profileImage,
    required this.email,
    required this.password,
    required this.skills,
    required this.availability,
    required this.experienceYears,
  });

  const AuthEntity.empty()
      : userId = null,
        freelancerName = '',
        portfolio = '',
        profileImage = null,
        email = '',
        password = '',
        skills = const [],
        availability = '',
        experienceYears = 0;

  @override
  List<Object?> get props => [
        userId,
        freelancerName,
        portfolio,
        email,
        profileImage,
        password,
        skills,
        availability,
        experienceYears,
      ];
}
