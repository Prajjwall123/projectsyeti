import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

part 'skill_api_model.g.dart';

@JsonSerializable()
class SkillApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? skillId;
  final String name;

  const SkillApiModel({
    this.skillId,
    required this.name,
  });

  factory SkillApiModel.fromJson(Map<String, dynamic> json) =>
      _$SkillApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$SkillApiModelToJson(this);

  factory SkillApiModel.fromEntity(SkillEntity entity) {
    return SkillApiModel(
      skillId: entity.skillId,
      name: entity.name,
    );
  }

  SkillEntity toEntity() {
    return SkillEntity(
      skillId: skillId,
      name: name,
    );
  }

  static List<SkillEntity> toEntityList(List<SkillApiModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }

  static List<SkillApiModel> fromEntityList(List<SkillEntity> entityList) {
    return entityList
        .map((entity) => SkillApiModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [skillId, name];
}
