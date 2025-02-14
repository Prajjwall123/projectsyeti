import 'package:dartz/dartz.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/project/domain/repository/project_repository.dart';
import '../entity/project_entity.dart';

class GetAllProjectsUsecase implements UsecaseWithParams<List<ProjectEntity>, NoParams> {
  final IProjectRepository projectRepository;

  GetAllProjectsUsecase({required this.projectRepository});

  @override
  Future<Either<Failure, List<ProjectEntity>>> call(NoParams params) async {
    return await projectRepository.getAllProjects();
  }
}

class NoParams {
  const NoParams();
}
