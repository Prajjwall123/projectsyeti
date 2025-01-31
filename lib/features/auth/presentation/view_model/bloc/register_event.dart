part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadSkills extends RegisterEvent {}

class UploadImage extends RegisterEvent {
  final File file;

  const UploadImage({
    required this.file,
  });
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String freelancerName;
  final String portfolio;
  final String email;
  final int experienceYears;
  final List<SkillEntity> skills;
  final String availability;
  final String password;
  final String? profileImage;

  const RegisterUser({
    required this.context,
    required this.freelancerName,
    required this.portfolio,
    required this.email,
    required this.experienceYears,
    required this.skills,
    required this.availability,
    required this.password,
    this.profileImage,
  });
}
