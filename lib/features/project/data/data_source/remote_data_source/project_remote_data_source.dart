import 'package:dio/dio.dart';
import 'package:projectsyeti/app/constants/api_endpoints.dart';
import 'package:projectsyeti/features/project/data/data_source/project_data_source.dart';
import 'package:projectsyeti/features/project/data/dto/get_all_projects_dto.dart';
import 'package:projectsyeti/features/project/data/dto/get_project_by_id_dto.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';

class ProjectRemoteDataSource implements IProjectDataSource {
  final Dio _dio;

  ProjectRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<List<ProjectEntity>> getAllProjects() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllProjects);
      if (response.statusCode == 200) {
        GetAllProjectsDTO projectsDTO =
            GetAllProjectsDTO.fromJson(response.data);
        return projectsDTO.data.map((project) => project.toEntity()).toList();
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
        return projectDTO.data.toEntity();
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
