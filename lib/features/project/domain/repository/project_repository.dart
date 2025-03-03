import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/project_entity.dart';

abstract interface class IProjectRepository {
  Future<Either<Failure, List<ProjectEntity>>> getAllProjects();

  Future<Either<Failure, ProjectEntity>> getProjectById(String projectId);

  Future<Either<Failure, List<ProjectEntity>>> getProjectsByFreelancerId(
      String freelancerId);

  Future<Either<Failure, ProjectEntity>> updateProjectById(
      String projectId, ProjectEntity updatedProject);
}
