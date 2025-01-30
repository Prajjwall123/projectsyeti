import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

part 'skill_api_model.g.dart';

@JsonSerializable()
class SkillApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? skillId;
  final String skillName;

  const SkillApiModel({
    this.skillId,
    required this.skillName,
  });

  factory SkillApiModel.fromJson(Map<String, dynamic> json) =>
      _$SkillApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$SkillApiModelToJson(this);

  // To entity

// From Entity
  factory SkillApiModel.fromEntity(SkillEntity entity) {
    return SkillApiModel(
      skillId: entity.skillId,
      skillName: entity.skillName,
    );
  }

  // To Entity
  SkillEntity toEntity() {
    return SkillEntity(
      skillId: skillId,
      skillName: skillName,
    );
  }

  // To Entity List
  static List<SkillEntity> toEntityList(List<SkillApiModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }

  // From entity list
  static List<SkillApiModel> fromEntityList(List<SkillEntity> entityList) {
    return entityList
        .map((entity) => SkillApiModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
