import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/project_entity.dart';

part 'project_api_model.g.dart';

@JsonSerializable()
class ProjectApiModel extends Equatable {
  @JsonKey(name: 'projectId')
  final String? projectId;
  final String companyId;
  final String companyName;
  final String companyLogo;
  final String headquarters;
  final String title;
  final List<String> category;
  final String requirements;
  final String description;
  final String duration;
  final DateTime postedDate;
  final String status;

  const ProjectApiModel({
    this.projectId,
    required this.companyId,
    required this.companyName,
    required this.companyLogo,
    required this.title,
    required this.headquarters,
    required this.category,
    required this.requirements,
    required this.description,
    required this.duration,
    required this.postedDate,
    required this.status,
  });

  factory ProjectApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectApiModelToJson(this);

  ProjectEntity toEntity() {
    return ProjectEntity(
      projectId: projectId,
      companyId: companyId,
      companyName: companyName,
      companyLogo: companyLogo,
      title: title,
      headquarters: headquarters,
      category: category,
      requirements: requirements,
      description: description,
      duration: duration,
      postedDate: postedDate,
      status: status,
    );
  }

  @override
  List<Object?> get props => [
        projectId,
        companyId,
        companyName,
        companyLogo,
        title,
        headquarters,
        category,
        requirements,
        description,
        duration,
        postedDate,
        status,
      ];
}
