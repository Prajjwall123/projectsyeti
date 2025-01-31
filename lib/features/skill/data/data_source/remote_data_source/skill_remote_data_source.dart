import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/app/constants/api_endpoints.dart';
import 'package:projectsyeti/features/skill/data/data_source/skill_data_source.dart';
import 'package:projectsyeti/features/skill/data/dto/get_all_skill_dto.dart';
import 'package:projectsyeti/features/skill/data/model/skill_api_model.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

class SkillRemoteDataSource implements ISkillDataSource {
  final Dio _dio;
  SkillRemoteDataSource(this._dio);

  @override
  Future<void> createSkill(SkillEntity skill) {
    // TODO: implement createSkill
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSkill(String id) {
    // TODO: implement deleteSkill
    throw UnimplementedError();
  }

  @override
  Future<List<SkillEntity>> getSkills() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllSkills);
      if (response.statusCode == 200) {
        // Convert API response to DTO
        var SkillDTO = GetAllSkillDTO.fromJson(response.data);
        debugPrint(response.data);
        // Convert DTO to Entity
        return SkillApiModel.toEntityList(SkillDTO.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
