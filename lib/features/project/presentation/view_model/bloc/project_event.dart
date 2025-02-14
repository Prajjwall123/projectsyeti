part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object?> get props => [];
}

final class GetAllProjectsEvent extends ProjectEvent {}

final class GetProjectByIdEvent extends ProjectEvent {
  final String projectId;

  const GetProjectByIdEvent(this.projectId);

  @override
  List<Object?> get props => [projectId];
}
