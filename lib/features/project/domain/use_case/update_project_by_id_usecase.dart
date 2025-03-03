import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/project/domain/repository/project_repository.dart';
import '../entity/project_entity.dart';

class UpdateProjectByIdParams extends Equatable {
  final String projectId;
  final ProjectEntity updatedProject;

  const UpdateProjectByIdParams({
    required this.projectId,
    required this.updatedProject,
  });

  @override
  List<Object?> get props => [projectId, updatedProject];
}

class UpdateProjectByIdUsecase
    implements UsecaseWithParams<ProjectEntity, UpdateProjectByIdParams> {
  final IProjectRepository projectRepository;

  UpdateProjectByIdUsecase({required this.projectRepository});

  @override
  Future<Either<Failure, ProjectEntity>> call(
      UpdateProjectByIdParams params) async {
    return await projectRepository.updateProjectById(
        params.projectId, params.updatedProject);
  }
}
