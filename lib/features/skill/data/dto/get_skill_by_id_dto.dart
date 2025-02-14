import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/skill/data/model/skill_api_model.dart';

part 'get_skill_by_id_dto.g.dart';

@JsonSerializable()
class GetSkillByIdDTO {
  final SkillApiModel skill;

  GetSkillByIdDTO({
    required this.skill,
  });

  factory GetSkillByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetSkillByIdDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetSkillByIdDTOToJson(this);
}
