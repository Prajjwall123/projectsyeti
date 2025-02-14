import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/app/constants/api_endpoints.dart';
import 'package:projectsyeti/features/project/data/data_source/project_data_source.dart';
import 'package:projectsyeti/features/project/data/model/project_api_model.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';

class ProjectRemoteDataSource implements IProjectDataSource {
  final Dio _dio;

  ProjectRemoteDataSource(this._dio);

  @override
  Future<List<ProjectEntity>> getAllProjects() async {
    try {
      Response response = await _dio.get(ApiEndpoints.getAllProjects);
      debugPrint("Fetched all projects");

      if (response.statusCode == 200) {
        final List projects = response.data as List;
        return projects
            .map((json) => ProjectApiModel.fromJson(json).toEntity())
            .toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch projects');
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
      Response response =
          await _dio.get('${ApiEndpoints.getProjectById}/$projectId');
      debugPrint("Fetched project by ID: $projectId");

      if (response.statusCode == 200) {
        return ProjectApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch project');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
