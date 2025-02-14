part of 'skill_bloc.dart';

class SkillState extends Equatable {
  final List<SkillEntity> skills;
  final SkillEntity? selectedSkill;
  final bool isLoading;
  final String? error;

  const SkillState({
    required this.skills,
    this.selectedSkill,
    required this.isLoading,
    this.error,
  });

  factory SkillState.initial() {
    return const SkillState(
      skills: [],
      selectedSkill: null,
      isLoading: false,
      error: null,
    );
  }

  SkillState copyWith({
    List<SkillEntity>? skills,
    SkillEntity? selectedSkill,
    bool? isLoading,
    String? error,
  }) {
    return SkillState(
      skills: skills ?? this.skills,
      selectedSkill: selectedSkill ?? this.selectedSkill,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [skills, selectedSkill, isLoading, error];
}
