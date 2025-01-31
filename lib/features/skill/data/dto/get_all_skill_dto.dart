import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/skill/data/model/skill_api_model.dart';

part 'get_all_skill_dto.g.dart';

@JsonSerializable()
class GetAllSkillDTO {
  final List<SkillApiModel> skills;

  GetAllSkillDTO({
    required this.skills,
  });

  factory GetAllSkillDTO.fromJson(List<dynamic> json) {
    return GetAllSkillDTO(
      skills: json.map((e) => SkillApiModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() => skills.map((e) => e.toJson()).toList();
}
