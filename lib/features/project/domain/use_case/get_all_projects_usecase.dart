import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/project/domain/repository/project_repository.dart';
import '../entity/project_entity.dart';

class GetAllProjectsUsecase
    implements UsecaseWithParams<List<ProjectEntity>, NoParams> {
  final IProjectRepository remoteRepository;
  final IProjectRepository localRepository;
  final Connectivity connectivity;

  GetAllProjectsUsecase({
    required this.remoteRepository,
    required this.localRepository,
    required this.connectivity,
  });

  Future<bool> _isConnected() async {
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      debugPrint("Connectivity check result: $connectivityResult");
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      debugPrint("Error checking connectivity: $e");
      return false;
    }
  }

  @override
  Future<Either<Failure, List<ProjectEntity>>> call(NoParams params) async {
    try {
      if (await _isConnected()) {
        debugPrint(
            "Connected to the internet, fetching projects from remote repository...");
        final result = await remoteRepository.getAllProjects();
        return result.fold(
          (failure) async {
            debugPrint("Remote fetch failed: ${failure.message}");
            return await _fetchFromLocal(
                "Remote fetch failed: ${failure.message}");
          },
          (projects) async {
            debugPrint(
                "Fetched ${projects.length} projects from remote repository.");
            for (var project in projects) {
              try {
                if (project.projectId == null) {
                  debugPrint("Skipping project with null projectId: $project");
                  continue;
                }
                await localRepository.updateProjectById(
                    project.projectId!, project);
                debugPrint(
                    "Stored project with ID: ${project.projectId} in Hive.");
              } catch (e) {
                debugPrint(
                    "Error storing project with ID: ${project.projectId} in Hive: $e");
              }
            }
            debugPrint("Finished storing projects in Hive.");
            return Right(projects);
          },
        );
      } else {
        debugPrint(
            "No internet connection, fetching projects from local repository...");
        return await _fetchFromLocal("No internet connection");
      }
    } catch (e) {
      debugPrint("Unexpected error during remote fetch: $e");
      return await _fetchFromLocal("Unexpected error during remote fetch: $e");
    }
  }

  Future<Either<Failure, List<ProjectEntity>>> _fetchFromLocal(
      String errorMessage) async {
    try {
      debugPrint("Falling back to local repository...");
      final result = await localRepository.getAllProjects();
      return result.fold(
        (failure) => Left(LocalDatabaseFailure(
            message: "$errorMessage, Local error: ${failure.message}")),
        (projects) {
          if (projects.isNotEmpty) {
            debugPrint(
                "Fetched ${projects.length} projects from local repository.");
            return Right(projects);
          } else {
            debugPrint("No projects found in local repository.");
            return Left(LocalDatabaseFailure(
                message: "$errorMessage, No projects found in local storage"));
          }
        },
      );
    } catch (localError) {
      debugPrint("Error fetching from local repository: $localError");
      return Left(LocalDatabaseFailure(
          message: "$errorMessage, Local error: $localError"));
    }
  }
}

class NoParams {
  const NoParams();
}
