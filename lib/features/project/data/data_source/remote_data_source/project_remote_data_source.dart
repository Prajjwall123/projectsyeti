import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/app/constants/api_endpoints.dart';
import 'package:projectsyeti/app/shared_prefs/token_shared_prefs.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/project/data/data_source/project_data_source.dart';
import 'package:projectsyeti/features/project/data/dto/get_all_projects_dto.dart';
import 'package:projectsyeti/features/project/data/dto/get_project_by_id_dto.dart';
import 'package:projectsyeti/features/project/data/model/project_api_model.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/skill/domain/repository/skill_repository.dart';

class ProjectRemoteDataSource implements IProjectDataSource {
  final Dio _dio;
  final ISkillRepository _skillRepository;
  final TokenSharedPrefs _tokenSharedPrefs;

  ProjectRemoteDataSource({
    required Dio dio,
    required ISkillRepository skillRepository,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _dio = dio,
        _skillRepository = skillRepository,
        _tokenSharedPrefs = tokenSharedPrefs;

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
          awardedTo: projectDTO.awardedTo,
          feedbackRequestedMessage: projectDTO.feedbackRequestedMessage,
          link: projectDTO.link,
          feedbackRespondMessage: projectDTO.feedbackRespondMessage,
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

  @override
  Future<List<ProjectEntity>> getProjectsByFreelancerId(
      String freelancerId) async {
    try {
      var response = await _dio
          .get('${ApiEndpoints.getProjectsByFreelancerId}/$freelancerId');
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
  Future<ProjectEntity> updateProjectById(
      String projectId, ProjectEntity updatedProject) async {
    try {
      // Fetch the token from TokenSharedPrefs
      final tokenResult = await _tokenSharedPrefs.getToken();
      String token = tokenResult.fold(
        (failure) =>
            throw Exception("Failed to retrieve token: ${failure.message}"),
        (token) {
          debugPrint("Token fetched: $token");
          return token;
        },
      );

      if (token.isEmpty) {
        throw Exception("Authentication token is missing");
      }

      // Fetch the userId from TokenSharedPrefs
      final userIdResult = await _tokenSharedPrefs.getUserId();
      String userId = userIdResult.fold(
        (failure) =>
            throw Exception("Failed to retrieve user ID: ${failure.message}"),
        (id) {
          debugPrint("User ID fetched: $id");
          return id;
        },
      );

      if (userId.isEmpty) {
        throw Exception("User ID is missing");
      }

      // Fetch all skills to map category names to ObjectIds
      Either<Failure, List<SkillEntity>> skillsResult =
          await _skillRepository.getSkills();
      List<SkillEntity> allSkills = skillsResult.fold(
        (failure) =>
            throw Exception("Failed to fetch skills: ${failure.message}"),
        (skills) => skills,
      );

      // Map category names to ObjectIds
      List<String> categoryIds = [];
      for (String categoryName in updatedProject.category) {
        SkillEntity? matchingSkill = allSkills.firstWhere(
          (skill) => skill.name == categoryName,
          orElse: () => throw Exception("Category not found: $categoryName"),
        );
        if (matchingSkill.skillId != null) {
          categoryIds.add(matchingSkill.skillId!);
          debugPrint(
              "Mapped category '$categoryName' to ObjectId: ${matchingSkill.skillId}");
        } else {
          throw Exception("Category ID not found for $categoryName");
        }
      }

      // Create a new ProjectApiModel with category ObjectIds and userId as awardedTo
      final projectModel = ProjectApiModel(
        projectId: updatedProject.projectId,
        companyId: updatedProject.companyId,
        companyName: updatedProject.companyName,
        companyLogo: updatedProject.companyLogo,
        title: updatedProject.title,
        headquarters: updatedProject.headquarters,
        category: categoryIds, // Use ObjectIds instead of names
        requirements: updatedProject.requirements,
        description: updatedProject.description,
        duration: updatedProject.duration,
        postedDate: updatedProject.postedDate,
        status: updatedProject.status,
        bidCount: updatedProject.bidCount,
        awardedTo: userId, // Set awardedTo to the userId
        feedbackRequestedMessage: updatedProject.feedbackRequestedMessage,
        link: updatedProject.link,
        feedbackRespondMessage: updatedProject.feedbackRespondMessage,
      );

      // Make the PUT request with the token in headers
      var response = await _dio.put(
        '${ApiEndpoints.updateProjectById}/$projectId',
        data: projectModel.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        ProjectApiModel updatedProjectModel =
            ProjectApiModel.fromJson(response.data);
        debugPrint('Updated Project ID: ${updatedProjectModel.projectId}');

        // Now fetch projects again by Freelancer ID to ensure updated data
        final projectsResult = await getProjectsByFreelancerId(userId);

        return updatedProjectModel.toEntity();
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
