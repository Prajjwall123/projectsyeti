part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;
  final List<SkillEntity> skills;

  const RegisterState({
    required this.isLoading,
    required this.isSuccess,
    required this.skills,
    this.imageName,
  });

  factory RegisterState.initial() {
    return const RegisterState(
      isLoading: false,
      isSuccess: false,
      skills: [],
    );
  }

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
    List<SkillEntity>? skills,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
      skills: skills ?? this.skills,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, imageName, skills];
}
