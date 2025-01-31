part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isOtpVerified;
  final String? email; // ✅ Stores email after registration
  final String? imageName;
  final String? profileImage;
  final List<SkillEntity> skills;

  const RegisterState({
    required this.isLoading,
    required this.isSuccess,
    required this.isOtpVerified,
    required this.skills,
    this.email, // ✅ Store email
    this.imageName,
    this.profileImage,
  });

  factory RegisterState.initial() {
    return const RegisterState(
      isLoading: false,
      isSuccess: false,
      isOtpVerified: false,
      skills: [],
      email: null, // ✅ Default email is null
      imageName: null,
      profileImage: null,
    );
  }

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isOtpVerified,
    String? email, // ✅ Email can be updated
    String? imageName,
    String? profileImage, // ✅ Correctly updating profileImage
    List<SkillEntity>? skills,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      email: email ?? this.email, // ✅ Ensure email is preserved
      imageName: imageName ?? this.imageName,
      profileImage: profileImage ?? this.profileImage, // ✅ Fix: Preserve profileImage
      skills: skills ?? this.skills,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isSuccess, isOtpVerified, email, imageName, profileImage, skills];
}
