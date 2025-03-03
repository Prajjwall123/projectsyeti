part of 'project_bloc.dart';

sealed class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object?> get props => [];
}

final class ProjectInitial extends ProjectState {}

final class ProjectLoading extends ProjectState {}

final class ProjectsLoaded extends ProjectState {
  final List<ProjectEntity> projects;

  const ProjectsLoaded(this.projects);

  @override
  List<Object?> get props => [projects];
}

final class ProjectLoaded extends ProjectState {
  final ProjectEntity project;

  const ProjectLoaded(this.project);

  @override
  List<Object?> get props => [project];
}

final class ProjectUpdated extends ProjectState {
  final ProjectEntity updatedProject;

  const ProjectUpdated(this.updatedProject);

  @override
  List<Object?> get props => [updatedProject];
}

final class ProjectError extends ProjectState {
  final String message;

  const ProjectError(this.message);

  @override
  List<Object?> get props => [message];
}
