import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/app/constants/api_endpoints.dart';
import 'package:projectsyeti/features/freelancer/data/data_source/freelancer_data_source.dart';
import 'package:projectsyeti/features/freelancer/data/dto/get_freelancer_by_id_dto.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';

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
              .map((cert) => cert.toEntity())
              .toList(),
          experience:
              freelancerDTO.experience.map((exp) => exp.toEntity()).toList(),
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
}
