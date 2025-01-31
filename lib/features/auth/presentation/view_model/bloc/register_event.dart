part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class FetchSkills extends RegisterEvent {}

class UploadImage extends RegisterEvent {
  final File file;

  const UploadImage({required this.file});

  @override
  List<Object> get props => [file];
}

class RegisterUser extends RegisterEvent {
  final String freelancerName;
  final String portfolio;
  final String email;
  final List<SkillEntity> skills;
  final String availability;
  final int experienceYears;
  final String password;
  final String profileImage;
  final BuildContext context;

  const RegisterUser({
    required this.freelancerName,
    required this.portfolio,
    required this.email,
    required this.skills,
    required this.availability,
    required this.experienceYears,
    required this.password,
    required this.profileImage,
    required this.context,
  });

  @override
  List<Object> get props => [
        freelancerName,
        portfolio,
        email,
        skills,
        availability,
        experienceYears,
        password,
        profileImage,
        context,
      ];
}
