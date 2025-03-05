import 'package:flutter/material.dart';
import 'package:projectsyeti/core/network/hive_service.dart';
import 'package:projectsyeti/features/project/data/model/project_hive_model.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/project/data/data_source/project_data_source.dart';

class ProjectLocalDataSource implements IProjectDataSource {
  final HiveService _hiveService;

  ProjectLocalDataSource(this._hiveService);

  @override
  Future<List<ProjectEntity>> getAllProjects() async {
    try {
      final projects = await _hiveService.getAllProjects();
      debugPrint('Total Projects Fetched Locally: ${projects.length}');
      return projects.map((projectModel) => projectModel.toEntity()).toList();
    } catch (e) {
      debugPrint('Error fetching all projects locally: $e');
      return Future.error('Failed to fetch projects: $e');
    }
  }

  @override
  Future<ProjectEntity> getProjectById(String projectId) async {
    try {
      final project = await _hiveService.getProjectById(projectId);
      if (project != null) {
        debugPrint('Fetched Project Locally - ID: $projectId');
        return project.toEntity();
      } else {
        return Future.error('Project not found with ID: $projectId');
      }
    } catch (e) {
      debugPrint('Error fetching project by ID locally: $e');
      return Future.error('Failed to fetch project: $e');
    }
  }

  @override
  Future<List<ProjectEntity>> getProjectsByFreelancerId(
      String freelancerId) async {
    try {
      final projects =
          await _hiveService.getProjectsByFreelancerId(freelancerId);
      debugPrint(
          'Total Projects Fetched for Freelancer ID $freelancerId Locally: ${projects.length}');
      return projects.map((projectModel) => projectModel.toEntity()).toList();
    } catch (e) {
      debugPrint('Error fetching projects by freelancer ID locally: $e');
      return Future.error('Failed to fetch projects for freelancer: $e');
    }
  }

  @override
  Future<ProjectEntity> updateProjectById(
      String projectId, ProjectEntity updatedProject) async {
    try {
      final projectHiveModel = ProjectHiveModel(
        id: updatedProject.projectId,
        companyId: updatedProject.companyId,
        companyName: updatedProject.companyName,
        companyLogo: updatedProject.companyLogo,
        headquarters: updatedProject.headquarters,
        title: updatedProject.title,
        category: updatedProject.category,
        requirements: updatedProject.requirements,
        description: updatedProject.description,
        duration: updatedProject.duration,
        postedDate: updatedProject.postedDate,
        status: updatedProject.status,
        bidCount: updatedProject.bidCount,
        awardedTo: updatedProject.awardedTo,
        feedbackRequestedMessage: updatedProject.feedbackRequestedMessage,
        link: updatedProject.link,
        feedbackRespondMessage: updatedProject.feedbackRespondMessage,
      );

      await _hiveService.updateProject(projectHiveModel);
      debugPrint('Updated Project Locally - ID: $projectId');

      final updatedProjectModel = await _hiveService.getProjectById(projectId);
      if (updatedProjectModel != null) {
        return updatedProjectModel.toEntity();
      } else {
        return Future.error('Updated project not found with ID: $projectId');
      }
    } catch (e) {
      debugPrint('Error updating project locally: $e');
      return Future.error('Failed to update project: $e');
    }
  }
}
