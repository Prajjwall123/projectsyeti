import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/skill/data/model/skill_api_model.dart';

part 'get_all_skill_dto.g.dart';

@JsonSerializable()
class GetAllSkillDTO {
  final List<SkillApiModel> data;

  GetAllSkillDTO({
    required this.data,
  });

  factory GetAllSkillDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllSkillDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllSkillDTOToJson(this);
}
