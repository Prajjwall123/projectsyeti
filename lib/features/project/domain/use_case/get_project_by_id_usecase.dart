import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/project/domain/repository/project_repository.dart';
import '../entity/project_entity.dart';

class GetProjectByIdParams extends Equatable {
  final String projectId;

  const GetProjectByIdParams({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}

class GetProjectByIdUsecase
    implements UsecaseWithParams<ProjectEntity, GetProjectByIdParams> {
  final IProjectRepository projectRepository;

  GetProjectByIdUsecase({required this.projectRepository});

  @override
  Future<Either<Failure, ProjectEntity>> call(
      GetProjectByIdParams params) async {
    return await projectRepository.getProjectById(params.projectId);
  }
}
