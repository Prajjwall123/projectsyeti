import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/app/constants/api_endpoints.dart';
import 'package:projectsyeti/features/project/data/data_source/project_data_source.dart';
import 'package:projectsyeti/features/project/data/dto/get_all_projects_dto.dart';
import 'package:projectsyeti/features/project/data/dto/get_project_by_id_dto.dart';
import 'package:projectsyeti/features/project/data/model/project_api_model.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/skill/data/model/skill_api_model.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/skill/domain/repository/skill_repository.dart';

class ProjectRemoteDataSource implements IProjectDataSource {
  final Dio _dio;
  final ISkillRepository _skillRepository;

  ProjectRemoteDataSource({
    required Dio dio,
    required ISkillRepository skillRepository,
  })  : _dio = dio,
        _skillRepository = skillRepository;

  @override
  Future<List<ProjectEntity>> getAllProjects() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllProjects);
      if (response.statusCode == 200) {
        List<dynamic> projectsList = response.data;

        List<ProjectEntity> projects = projectsList.map((projectJson) {
          ProjectApiModel projectModel = ProjectApiModel.fromJson(projectJson);
          debugPrint('Fetched Project ID: ${projectModel.projectId}');
          return projectModel.toEntity();
        }).toList();

        debugPrint('Total Projects Fetched: ${projects.length}');
        return projects;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  @override
  Future<ProjectEntity> getProjectById(String projectId) async {
    try {
      var response =
          await _dio.get('${ApiEndpoints.getProjectById}/$projectId');
      if (response.statusCode == 200) {
        GetProjectByIdDTO projectDTO =
            GetProjectByIdDTO.fromJson(response.data);

        return ProjectEntity(
          projectId: projectDTO.projectId,
          title: projectDTO.title,
          companyId: projectDTO.companyId,
          companyName: projectDTO.companyName,
          companyLogo: projectDTO.companyLogo,
          category: projectDTO.category,
          requirements: projectDTO.requirements,
          description: projectDTO.description,
          duration: projectDTO.duration,
          postedDate: projectDTO.postedDate,
          status: projectDTO.status,
          headquarters: projectDTO.headquarters,
          bidCount: projectDTO.bidCount,
        );
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
