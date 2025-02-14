import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/project/data/model/project_api_model.dart';

part 'get_project_by_id_dto.g.dart';

@JsonSerializable()
class GetProjectByIdDTO {
  @JsonKey(name: '_id')
  final String projectId;
  final ProjectApiModel data;

  GetProjectByIdDTO({
    required this.projectId,
    required this.data,
  });

  factory GetProjectByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetProjectByIdDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetProjectByIdDTOToJson(this);
}
