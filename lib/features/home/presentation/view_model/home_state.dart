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
  final bool isLoggingOut;
  final String? errorMessage;
  final String? skillsErrorMessage;
  final String? selectedSkill; // Add this field to track the selected skill

  const HomeState({
    required this.selectedIndex,
    required this.projects,
    required this.skills,
    this.freelancer,
    required this.isLoading,
    required this.isSkillsLoading,
    required this.isLoggingOut,
    this.errorMessage,
    this.skillsErrorMessage,
    this.selectedSkill, // Initialize as null by default (no filter)
  });

  static HomeState initial() {
    return const HomeState(
      selectedIndex: 0,
      projects: [],
      skills: [],
      freelancer: null,
      isLoading: false,
      isSkillsLoading: false,
      isLoggingOut: false,
      errorMessage: null,
      skillsErrorMessage: null,
      selectedSkill: null,
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<ProjectEntity>? projects,
    List<SkillEntity>? skills,
    FreelancerEntity? freelancer,
    bool? isLoading,
    bool? isSkillsLoading,
    bool? isLoggingOut,
    String? errorMessage,
    String? skillsErrorMessage,
    String? selectedSkill,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      projects: projects ?? this.projects,
      skills: skills ?? this.skills,
      freelancer: freelancer ?? this.freelancer,
      isLoading: isLoading ?? this.isLoading,
      isSkillsLoading: isSkillsLoading ?? this.isSkillsLoading,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      errorMessage: errorMessage,
      skillsErrorMessage: skillsErrorMessage,
      selectedSkill: selectedSkill,
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
        isLoggingOut,
        errorMessage,
        skillsErrorMessage,
        selectedSkill, // Add to props for Equatable
      ];
}
