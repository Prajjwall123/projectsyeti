import 'package:json_annotation/json_annotation.dart';

part 'seen_notification_by_freelancer_dto.g.dart';

@JsonSerializable()
class SeenNotificationByFreelancerDTO {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'isRead')
  final bool isRead;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  SeenNotificationByFreelancerDTO({
    required this.id,
    required this.isRead,
    required this.updatedAt,
  });

  factory SeenNotificationByFreelancerDTO.fromJson(Map<String, dynamic> json) =>
      _$SeenNotificationByFreelancerDTOFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SeenNotificationByFreelancerDTOToJson(this);
}
