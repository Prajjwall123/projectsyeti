import 'package:equatable/equatable.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<ProjectEntity> projects;
  final List<SkillEntity> skills;
  final FreelancerEntity? freelancer;
  final int? walletAmount;
  final bool isLoading;
  final bool isSkillsLoading;
  final bool isLoggingOut;
  final String? errorMessage;
  final String? skillsErrorMessage;
  final String? walletErrorMessage;
  final String? selectedSkill;

  const HomeState({
    required this.selectedIndex,
    required this.projects,
    required this.skills,
    this.freelancer,
    this.walletAmount,
    required this.isLoading,
    required this.isSkillsLoading,
    required this.isLoggingOut,
    this.errorMessage,
    this.skillsErrorMessage,
    this.walletErrorMessage,
    this.selectedSkill,
  });

  static HomeState initial() {
    return const HomeState(
      selectedIndex: 0,
      projects: [],
      skills: [],
      freelancer: null,
      walletAmount: null,
      isLoading: false,
      isSkillsLoading: false,
      isLoggingOut: false,
      errorMessage: null,
      skillsErrorMessage: null,
      walletErrorMessage: null,
      selectedSkill: null,
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<ProjectEntity>? projects,
    List<SkillEntity>? skills,
    FreelancerEntity? freelancer,
    int? walletAmount,
    bool? isLoading,
    bool? isSkillsLoading,
    bool? isLoggingOut,
    String? errorMessage,
    String? skillsErrorMessage,
    String? walletErrorMessage,
    String? selectedSkill,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      projects: projects ?? this.projects,
      skills: skills ?? this.skills,
      freelancer: freelancer ?? this.freelancer,
      walletAmount: walletAmount ?? this.walletAmount,
      isLoading: isLoading ?? this.isLoading,
      isSkillsLoading: isSkillsLoading ?? this.isSkillsLoading,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      errorMessage: errorMessage,
      skillsErrorMessage: skillsErrorMessage,
      walletErrorMessage: walletErrorMessage,
      selectedSkill: selectedSkill,
    );
  }

  @override
  List<Object?> get props => [
        selectedIndex,
        projects,
        skills,
        freelancer,
        walletAmount,
        isLoading,
        isSkillsLoading,
        isLoggingOut,
        errorMessage,
        skillsErrorMessage,
        walletErrorMessage,
        selectedSkill,
      ];
}
