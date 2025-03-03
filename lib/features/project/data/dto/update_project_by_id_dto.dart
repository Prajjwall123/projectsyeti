import 'package:json_annotation/json_annotation.dart';

part 'update_project_by_id_dto.g.dart';

@JsonSerializable()
class UpdateProjectByIdDTO {
  @JsonKey(name: '_id')
  final String projectId;

  @JsonKey(name: 'title')
  final String? title; // Allow null values safely

  @JsonKey(name: 'company')
  final String? companyId; // Allow null values safely

  @JsonKey(name: 'companyName')
  final String? companyName; // Allow null values safely

  @JsonKey(name: 'category')
  final List<String>? category; // Ensure null safety for category

  @JsonKey(name: 'requirements')
  final String? requirements; // Allow null values safely

  @JsonKey(name: 'description')
  final String? description; // Allow null values safely

  @JsonKey(name: 'duration')
  final String? duration; // Allow null values safely

  @JsonKey(name: 'postedDate')
  final DateTime? postedDate; // Allow null values safely

  @JsonKey(name: 'status')
  final String? status; // Allow null values safely

  @JsonKey(name: 'awardedTo')
  final String? awardedTo; // Keep nullable

  @JsonKey(name: 'feedbackRequestedMessage')
  final String? feedbackRequestedMessage; // Keep nullable

  @JsonKey(name: 'feedbackRespondMessage')
  final String? feedbackRespondMessage; // Keep nullable

  @JsonKey(name: 'link')
  final String? link; // Keep nullable

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt; // Allow null safety

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt; // Allow null safety

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
