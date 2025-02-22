import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/notification_entity.dart';

part 'notification_api_model.g.dart';

@JsonSerializable()
class NotificationApiModel extends Equatable {
  @JsonKey(name: 'id')
  final String notificationId;
  final String recipient;
  final String recipientType;
  final String message;
  final bool isRead;
  final DateTime createdAt;

  const NotificationApiModel({
    required this.notificationId,
    required this.recipient,
    required this.recipientType,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationApiModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationApiModelToJson(this);

  NotificationEntity toEntity() {
    return NotificationEntity(
      notificationId: notificationId,
      recipient: recipient,
      recipientType: recipientType,
      message: message,
      isRead: isRead,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [
        notificationId,
        recipient,
        recipientType,
        message,
        isRead,
        createdAt,
      ];
}
