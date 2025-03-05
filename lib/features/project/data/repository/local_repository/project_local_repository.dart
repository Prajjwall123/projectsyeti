import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/project/data/data_source/local_data_source/project_local_data_source.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/project/domain/repository/project_repository.dart';

class ProjectLocalRepository implements IProjectRepository {
  final ProjectLocalDataSource _projectLocalDataSource;

  ProjectLocalRepository(this._projectLocalDataSource);

  @override
  Future<Either<Failure, List<ProjectEntity>>> getAllProjects() async {
    try {
      debugPrint("Fetching all projects locally...");
      final projects = await _projectLocalDataSource.getAllProjects();
      return Right(projects);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> getProjectById(
      String projectId) async {
    try {
      debugPrint("Fetching project with ID locally: $projectId");
      final project = await _projectLocalDataSource.getProjectById(projectId);
      return Right(project);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProjectEntity>>> getProjectsByFreelancerId(
      String freelancerId) async {
    try {
      debugPrint("Fetching all projects by Freelancer Id locally...");
      final projects =
          await _projectLocalDataSource.getProjectsByFreelancerId(freelancerId);
      return Right(projects);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> updateProjectById(
      String projectId, ProjectEntity updatedProject) async {
    try {
      debugPrint("Updating project with ID locally: $projectId");
      final updatedProjectEntity = await _projectLocalDataSource
          .updateProjectById(projectId, updatedProject);
      return Right(updatedProjectEntity);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
