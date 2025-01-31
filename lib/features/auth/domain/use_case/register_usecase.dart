import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/auth/domain/entity/auth_entity.dart';
import 'package:projectsyeti/features/auth/domain/repository/auth_repository.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

class RegisterUserParams extends Equatable {
  final String freelancerName;
  final String? profileImage;
  final List<SkillEntity> skills;
  final String email;
  final String password;
  final String portfolio;
  final String availability;
  final int experienceYears;

  const RegisterUserParams({
    required this.freelancerName,
    required this.portfolio,
    this.profileImage,
    required this.email,
    required this.password,
    required this.skills,
    required this.availability,
    required this.experienceYears,
  });

  //initial constructor
  const RegisterUserParams.initial({
    required this.freelancerName,
    required this.portfolio,
    this.profileImage,
    required this.email,
    required this.password,
    required this.skills,
    required this.availability,
    required this.experienceYears,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        freelancerName,
        portfolio,
        profileImage,
        email,
        password,
        skills,
        availability,
        experienceYears
      ];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;
  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      freelancerName: params.freelancerName,
      portfolio: params.portfolio,
      email: params.email,
      skills: params.skills,
      availability: params.availability,
      experienceYears: params.experienceYears,
      password: params.password,
      profileImage: params.profileImage,
    );
    return repository.registerUser(authEntity);
  }
}
