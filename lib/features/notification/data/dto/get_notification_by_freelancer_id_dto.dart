import 'package:json_annotation/json_annotation.dart';

part 'get_notification_by_freelancer_id_dto.g.dart';

@JsonSerializable()
class GetNotificationByFreelancerIdDTO {
  @JsonKey(name: 'id')
  final String id;
  final String recipient;
  final String recipientType;
  final String message;
  final bool isRead;
  final DateTime createdAt;

  GetNotificationByFreelancerIdDTO({
    required this.id,
    required this.recipient,
    required this.recipientType,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  factory GetNotificationByFreelancerIdDTO.fromJson(
          Map<String, dynamic> json) =>
      _$GetNotificationByFreelancerIdDTOFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetNotificationByFreelancerIdDTOToJson(this);
}
