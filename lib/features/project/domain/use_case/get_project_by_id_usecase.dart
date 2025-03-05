import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
  final IProjectRepository remoteRepository;
  final IProjectRepository localRepository;
  final Connectivity connectivity;

  GetProjectByIdUsecase({
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
  Future<Either<Failure, ProjectEntity>> call(
      GetProjectByIdParams params) async {
    try {
      if (await _isConnected()) {
        debugPrint(
            "Connected to the internet, fetching project with ID: ${params.projectId} from remote repository...");
        final result = await remoteRepository.getProjectById(params.projectId);
        return result.fold(
          (failure) async {
            debugPrint("Remote fetch failed: ${failure.message}");
            return await _fetchFromLocal(
                params.projectId, "Remote fetch failed: ${failure.message}");
          },
          (project) async {
            debugPrint(
                "Fetched project with ID: ${params.projectId} from remote repository.");
            try {
              if (project.projectId == null) {
                debugPrint("Skipping project with null projectId: $project");
              } else {
                await localRepository.updateProjectById(
                    project.projectId!, project);
                debugPrint(
                    "Stored project with ID: ${project.projectId} in Hive.");
              }
            } catch (e) {
              debugPrint(
                  "Error storing project with ID: ${project.projectId} in Hive: $e");
            }
            return Right(project);
          },
        );
      } else {
        debugPrint(
            "No internet connection, fetching project with ID: ${params.projectId} from local repository...");
        return await _fetchFromLocal(
            params.projectId, "No internet connection");
      }
    } catch (e) {
      debugPrint("Unexpected error during remote fetch: $e");
      return await _fetchFromLocal(
          params.projectId, "Unexpected error during remote fetch: $e");
    }
  }

  Future<Either<Failure, ProjectEntity>> _fetchFromLocal(
      String projectId, String errorMessage) async {
    try {
      debugPrint(
          "Falling back to local repository for project ID: $projectId...");
      final result = await localRepository.getProjectById(projectId);
      return result.fold(
        (failure) => Left(LocalDatabaseFailure(
            message: "$errorMessage, Local error: ${failure.message}")),
        (project) {
          debugPrint(
              "Fetched project with ID: $projectId from local repository.");
          return Right(project);
        },
      );
    } catch (localError) {
      debugPrint(
          "Error fetching from local repository for project ID: $projectId: $localError");
      return Left(LocalDatabaseFailure(
          message: "$errorMessage, Local error: $localError"));
    }
  }
}
