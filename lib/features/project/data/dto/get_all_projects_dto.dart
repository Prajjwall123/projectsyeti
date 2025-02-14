import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/project/data/model/project_api_model.dart';

part 'get_all_projects_dto.g.dart';

@JsonSerializable()
class GetAllProjectsDTO {
  final bool success;
  final int count;
  final List<ProjectApiModel> data;

  GetAllProjectsDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  factory GetAllProjectsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllProjectsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllProjectsDTOToJson(this);
}
