import 'package:json_annotation/json_annotation.dart';

part 'update_project_by_id_dto.g.dart';

@JsonSerializable()
class UpdateProjectByIdDTO {
  @JsonKey(name: '_id')
  final String projectId;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'company')
  final String? companyId;

  @JsonKey(name: 'companyName')
  final String? companyName;

  @JsonKey(name: 'category')
  final List<String>? category;

  @JsonKey(name: 'requirements')
  final String? requirements;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'duration')
  final String? duration;

  @JsonKey(name: 'postedDate')
  final DateTime? postedDate;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'awardedTo')
  final String? awardedTo;

  @JsonKey(name: 'feedbackRequestedMessage')
  final String? feedbackRequestedMessage;

  @JsonKey(name: 'feedbackRespondMessage')
  final String? feedbackRespondMessage;

  @JsonKey(name: 'link')
  final String? link;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  UpdateProjectByIdDTO({
    required this.projectId,
    this.title,
    this.companyId,
    this.companyName,
    this.category,
    this.requirements,
    this.description,
    this.duration,
    this.postedDate,
    this.status,
    this.awardedTo,
    this.feedbackRequestedMessage,
    this.feedbackRespondMessage,
    this.link,
    this.createdAt,
    this.updatedAt,
  });

  factory UpdateProjectByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdateProjectByIdDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProjectByIdDTOToJson(this);
}
