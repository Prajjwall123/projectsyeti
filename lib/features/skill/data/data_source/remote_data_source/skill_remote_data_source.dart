import 'package:dio/dio.dart';
import 'package:projectsyeti/app/constants/api_endpoints.dart';
import 'package:projectsyeti/features/skill/data/data_source/skill_data_source.dart';
import 'package:projectsyeti/features/skill/data/dto/get_all_skill_dto.dart';
import 'package:projectsyeti/features/skill/data/dto/get_skill_by_id_dto.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

class SkillRemoteDataSource implements ISkillDataSource {
  final Dio _dio;

  SkillRemoteDataSource(this._dio);

  @override
  Future<List<SkillEntity>> getSkills() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllSkills);
      if (response.statusCode == 200) {
        List<dynamic> skillList = response.data;
        var skillDTO = GetAllSkillDTO.fromJson(skillList);
        return skillDTO.skills.map((skill) => skill.toEntity()).toList();
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
  Future<SkillEntity> getSkillById(String skillId) async {
    try {
      var response = await _dio.get('${ApiEndpoints.getSkillById}/$skillId');
      if (response.statusCode == 200) {
        var skillDTO = GetSkillByIdDTO.fromJson(response.data);
        return skillDTO.skill.toEntity();
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
