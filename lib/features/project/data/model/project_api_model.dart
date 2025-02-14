import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/skill/data/model/skill_api_model.dart';
import '../../domain/entity/project_entity.dart';

part 'project_api_model.g.dart';

@JsonSerializable()
class ProjectApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? projectId;
  final String companyId;
  final String title;
  final List<SkillApiModel> category;
  final String requirements;
  final String description;
  final String duration;
  final DateTime postedDate;
  final String status;

  const ProjectApiModel({
    this.projectId,
    required this.companyId,
    required this.title,
    required this.category,
    required this.requirements,
    required this.description,
    required this.duration,
    required this.postedDate,
    required this.status,
  });

  /// From JSON
  factory ProjectApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectApiModelFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$ProjectApiModelToJson(this);

  /// Convert to Domain Entity
  ProjectEntity toEntity() {
    return ProjectEntity(
      projectId: projectId,
      companyId: companyId,
      title: title,
      category: category.map((e) => e.toEntity()).toList(),
      requirements: requirements,
      description: description,
      duration: duration,
      postedDate: postedDate,
      status: status,
    );
  }

  /// Create API Model from Domain Entity
  factory ProjectApiModel.fromEntity(ProjectEntity entity) {
    return ProjectApiModel(
      projectId: entity.projectId,
      companyId: entity.companyId,
      title: entity.title,
      category:
          entity.category.map((e) => SkillApiModel.fromEntity(e)).toList(),
      requirements: entity.requirements,
      description: entity.description,
      duration: entity.duration,
      postedDate: entity.postedDate,
      status: entity.status,
    );
  }

  @override
  List<Object?> get props => [
        projectId,
        companyId,
        title,
        category,
        requirements,
        description,
        duration,
        postedDate,
        status,
      ];
}
