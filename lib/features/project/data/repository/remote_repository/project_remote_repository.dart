import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/project/data/data_source/remote_data_source/project_remote_data_source.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/project/domain/repository/project_repository.dart';

class ProjectRemoteRepository implements IProjectRepository {
  final ProjectRemoteDataSource _projectRemoteDataSource;

  ProjectRemoteRepository(this._projectRemoteDataSource);

  @override
  Future<Either<Failure, List<ProjectEntity>>> getAllProjects() async {
    try {
      debugPrint("Fetching all projects...");
      final projects = await _projectRemoteDataSource.getAllProjects();
      return Right(projects);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> getProjectById(
      String projectId) async {
    try {
      debugPrint("Fetching project with ID: $projectId");
      final project = await _projectRemoteDataSource.getProjectById(projectId);
      return Right(project);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
