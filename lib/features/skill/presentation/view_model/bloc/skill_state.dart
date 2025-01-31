part of 'skill_bloc.dart';

class SkillState extends Equatable {
  final List<SkillEntity> skills;
  final bool isLoading;
  final String? error;

  const SkillState({
    required this.skills,
    required this.isLoading,
    this.error,
  });

  factory SkillState.initial() {
    return const SkillState(
      skills: [],
      isLoading: false,
    );
  }

  SkillState copyWith({
    List<SkillEntity>? skills,
    bool? isLoading,
    String? error,
  }) {
    return SkillState(
      skills: skills ?? this.skills,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [skills, isLoading, error];
}
