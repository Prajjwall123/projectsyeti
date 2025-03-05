import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/project/domain/use_case/get_all_projects_usecase.dart';
import 'package:projectsyeti/features/project/domain/use_case/get_project_by_id_usecase.dart';
import 'package:projectsyeti/features/project/domain/use_case/get_projects_by_freelancer_usecase.dart';
import 'package:projectsyeti/features/project/domain/use_case/update_project_by_id_usecase.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final GetAllProjectsUsecase getAllProjectsUsecase;
  final GetProjectByIdUsecase getProjectByIdUsecase;
  final GetProjectsByFreelancerIdUsecase getProjectByFreelancerIdUsecase;
  final UpdateProjectByIdUsecase updateProjectByIdUsecase;

  ProjectBloc({
    required this.getAllProjectsUsecase,
    required this.getProjectByIdUsecase,
    required this.getProjectByFreelancerIdUsecase,
    required this.updateProjectByIdUsecase,
  }) : super(ProjectInitial()) {
    on<GetAllProjectsEvent>(_onGetAllProjects);
    on<GetProjectByIdEvent>(_onGetProjectById);
    on<GetProjectsByFreelancerIdEvent>(_onGetProjectsByFreelancer);
    on<UpdateProjectByIdEvent>(_onUpdateProjectById);
  }

  Future<void> _onGetAllProjects(
    GetAllProjectsEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectLoading());
    final Either<Failure, List<ProjectEntity>> result =
        await getAllProjectsUsecase(const NoParams());

    result.fold(
      (failure) => emit(ProjectError(_mapFailureToMessage(failure))),
      (projects) => emit(ProjectsLoaded(projects)),
    );
  }

  Future<void> _onGetProjectsByFreelancer(
    GetProjectsByFreelancerIdEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectLoading());
    final Either<Failure, List<ProjectEntity>> result =
        await getProjectByFreelancerIdUsecase(
            GetProjectsByFreelancerIdParams(freelancerId: event.freelancerId));

    result.fold(
      (failure) => emit(ProjectError(_mapFailureToMessage(failure))),
      (projects) => emit(ProjectsLoaded(projects)),
    );
  }

  Future<void> _onGetProjectById(
    GetProjectByIdEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectLoading());
    final Either<Failure, ProjectEntity> result = await getProjectByIdUsecase(
        GetProjectByIdParams(projectId: event.projectId));

    result.fold(
      (failure) => emit(ProjectError(_mapFailureToMessage(failure))),
      (project) => emit(ProjectLoaded(project)),
    );
  }

  Future<void> _onUpdateProjectById(
    UpdateProjectByIdEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectLoading());
    final Either<Failure, ProjectEntity> result =
        await updateProjectByIdUsecase(UpdateProjectByIdParams(
      projectId: event.projectId,
      updatedProject: event.updatedProject,
    ));

    result.fold(
      (failure) => emit(ProjectError(_mapFailureToMessage(failure))),
      (updatedProject) {
        emit(ProjectUpdated(updatedProject));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ApiFailure) {
      return failure.message ?? 'An unexpected error occurred';
    }
    return 'An unexpected error occurred';
  }
}
