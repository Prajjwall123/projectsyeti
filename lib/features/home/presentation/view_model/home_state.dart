import 'package:equatable/equatable.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<ProjectEntity> projects;
  final List<SkillEntity> skills;
  final FreelancerEntity? freelancer;
  final bool isLoading;
  final bool isSkillsLoading;
  final String? errorMessage;
  final String? skillsErrorMessage;

  const HomeState({
    required this.selectedIndex,
    required this.projects,
    required this.skills,
    this.freelancer,
    required this.isLoading,
    required this.isSkillsLoading,
    this.errorMessage,
    this.skillsErrorMessage,
  });

  /// **Initial state**
  static HomeState initial() {
    return const HomeState(
      selectedIndex: 0,
      projects: [],
      skills: [],
      freelancer: null,
      isLoading: false,
      isSkillsLoading: false,
      errorMessage: null,
      skillsErrorMessage: null,
    );
  }

  /// **Copy with method to update state**
  HomeState copyWith({
    int? selectedIndex,
    List<ProjectEntity>? projects,
    List<SkillEntity>? skills,
    FreelancerEntity? freelancer,
    bool? isLoading,
    bool? isSkillsLoading,
    String? errorMessage,
    String? skillsErrorMessage,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      projects: projects ?? this.projects,
      skills: skills ?? this.skills,
      freelancer: freelancer ?? this.freelancer,
      isLoading: isLoading ?? this.isLoading,
      isSkillsLoading: isSkillsLoading ?? this.isSkillsLoading,
      errorMessage: errorMessage,
      skillsErrorMessage: skillsErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        selectedIndex,
        projects,
        skills,
        freelancer,
        isLoading,
        isSkillsLoading,
        errorMessage,
        skillsErrorMessage,
      ];
}
