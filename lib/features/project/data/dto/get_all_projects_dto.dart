import 'package:json_annotation/json_annotation.dart';

part 'get_all_projects_dto.g.dart';

@JsonSerializable()
class GetAllProjectsDTO {
  @JsonKey(name: 'projectId')
  final String projectId;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'companyId')
  final String companyId;

  @JsonKey(name: 'headquarters')
  final String? headquarters;

  @JsonKey(name: 'companyName')
  final String companyName;

  @JsonKey(name: 'companyLogo')
  final String companyLogo;

  @JsonKey(name: 'category')
  final List<String> category;

  @JsonKey(name: 'requirements')
  final String requirements;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'duration')
  final String duration;

  @JsonKey(name: 'postedDate')
  final DateTime postedDate;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'bidCount')
  final int bidCount;

  @JsonKey(name: 'awardedTo')
  final String? awardedTo;

  @JsonKey(name: 'feedbackRequestedMessage')
  final String? feedbackRequestedMessage;

  @JsonKey(name: 'link')
  final String? link;

  @JsonKey(name: 'feedbackRespondMessage')
  final String? feedbackRespondMessage;

  GetAllProjectsDTO({
    required this.projectId,
    required this.title,
    required this.companyId,
    required this.companyName,
    this.headquarters,
    required this.companyLogo,
    required this.category,
    required this.requirements,
    required this.description,
    required this.duration,
    required this.postedDate,
    required this.status,
    required this.bidCount,
    this.awardedTo,
    this.feedbackRequestedMessage,
    this.link,
    this.feedbackRespondMessage,
  });

  factory GetAllProjectsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllProjectsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllProjectsDTOToJson(this);
}
