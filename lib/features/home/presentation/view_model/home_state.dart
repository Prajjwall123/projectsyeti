import 'package:equatable/equatable.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<ProjectEntity> projects;
  final bool isLoading;
  final String? errorMessage;

  const HomeState({
    required this.selectedIndex,
    required this.projects,
    required this.isLoading,
    this.errorMessage,
  });

  static HomeState initial() {
    return const HomeState(
      selectedIndex: 0,
      projects: [],
      isLoading: false,
      errorMessage: null,
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<ProjectEntity>? projects,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, projects, isLoading, errorMessage];
}
