part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class FetchSkills extends RegisterEvent {}

class VerifyOtp extends RegisterEvent {
  final String otp;
  final BuildContext context;
  final String email;

  const VerifyOtp({
    required this.otp,
    required this.context,
    required this.email,
  });

  @override
  List<Object> get props => [otp, context];
}

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

// New event for verifying OTP
class VerifyOtpEvent extends RegisterEvent {
  final String email;
  final String otp;
  final BuildContext context;

  const VerifyOtpEvent({
    required this.email,
    required this.otp,
    required this.context,
  });

  @override
  List<Object> get props => [email, otp, context];
}
