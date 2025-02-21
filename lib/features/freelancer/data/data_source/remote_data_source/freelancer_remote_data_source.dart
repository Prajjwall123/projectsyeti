import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/app/constants/api_endpoints.dart';
import 'package:projectsyeti/features/certification/data/model/certification_api_model.dart';
import 'package:projectsyeti/features/experience/data/model/experience_api_model.dart';
import 'package:projectsyeti/features/freelancer/data/data_source/freelancer_data_source.dart';
import 'package:projectsyeti/features/freelancer/data/dto/get_freelancer_by_id_dto.dart';
import 'package:projectsyeti/features/freelancer/data/dto/update_freelancer_by_id_dto.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/skill/data/model/skill_api_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FreelancerRemoteDataSource implements IFreelancerDataSource {
  final Dio _dio;

  FreelancerRemoteDataSource(Dio dio) : _dio = dio;

  @override
  Future<FreelancerEntity> getFreelancerById(String freelancerId) async {
    try {
      var response =
          await _dio.get('${ApiEndpoints.getFreelancerById}/$freelancerId');

      if (response.statusCode == 200) {
        GetFreelancerByIdDTO freelancerDTO =
            GetFreelancerByIdDTO.fromJson(response.data);

        return FreelancerEntity(
          id: freelancerDTO.id,
          skills:
              freelancerDTO.skills.map((skill) => skill.toEntity()).toList(),
          experienceYears: freelancerDTO.experienceYears,
          freelancerName: freelancerDTO.freelancerName,
          availability: freelancerDTO.availability,
          portfolio: freelancerDTO.portfolio,
          profileImage: freelancerDTO.profileImage,
          projectsCompleted: freelancerDTO.projectsCompleted,
          createdAt: freelancerDTO.createdAt,
          updatedAt: freelancerDTO.updatedAt,
          certifications: freelancerDTO.certifications
              ?.map((cert) => cert.toEntity())
              .toList(),
          experience:
              freelancerDTO.experience?.map((exp) => exp.toEntity()).toList(),
          languages: freelancerDTO.languages,
          profession: freelancerDTO.profession,
          location: freelancerDTO.location,
          aboutMe: freelancerDTO.aboutMe,
          workAt: freelancerDTO.workAt,
          userId: freelancerDTO.userId,
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
  Future<FreelancerEntity> updateFreelancerById(
      String freelancerId, FreelancerEntity freelancer) async {
    try {
      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token is missing');
      }

      // Create the DTO with all required fields
      final updateDTO = UpdateFreelancerByIdDTO(
        id: freelancer.id,
        skills: freelancer.skills
            .map((skill) => SkillApiModel.fromEntity(skill))
            .toList(),
        experienceYears: freelancer.experienceYears,
        freelancerName: freelancer.freelancerName,
        availability: freelancer.availability,
        portfolio: freelancer.portfolio,
        profileImage: freelancer.profileImage,
        projectsCompleted: freelancer.projectsCompleted,
        certifications: freelancer.certifications
            ?.map((cert) => CertificationApiModel.fromEntity(cert))
            .toList(),
        experience: freelancer.experience
            ?.map((exp) => ExperienceApiModel.fromEntity(exp))
            .toList(),
        languages: freelancer.languages,
        profession: freelancer.profession,
        location: freelancer.location,
        aboutMe: freelancer.aboutMe,
        workAt: freelancer.workAt,
      );
      // debugPrint(updateDTO.toJson() as String?);

      // Send the PUT request with the token in headers
      var response = await _dio.put(
        '${ApiEndpoints.updateFreelancerById}/$freelancerId',
        data: updateDTO.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      debugPrint("Response: ${response.data}");

      if (response.statusCode == 200) {
        // On success, map the response to a FreelancerEntity
        GetFreelancerByIdDTO freelancerDTO =
            GetFreelancerByIdDTO.fromJson(response.data);
        return FreelancerEntity(
          id: freelancerDTO.id,
          skills:
              freelancerDTO.skills.map((skill) => skill.toEntity()).toList(),
          experienceYears: freelancerDTO.experienceYears,
          freelancerName: freelancerDTO.freelancerName,
          availability: freelancerDTO.availability,
          portfolio: freelancerDTO.portfolio,
          profileImage: freelancerDTO.profileImage,
          projectsCompleted: freelancerDTO.projectsCompleted,
          createdAt: freelancerDTO.createdAt,
          updatedAt: freelancerDTO.updatedAt,
          certifications: freelancerDTO.certifications
              ?.map((cert) => cert.toEntity())
              .toList(),
          experience:
              freelancerDTO.experience?.map((exp) => exp.toEntity()).toList(),
          languages: freelancerDTO.languages,
          profession: freelancerDTO.profession,
          location: freelancerDTO.location,
          aboutMe: freelancerDTO.aboutMe,
          workAt: freelancerDTO.workAt,
          userId: freelancerDTO.userId,
        );
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    } catch (e) {
      throw Exception('Error updating freelancer: $e');
    }
  }
}
