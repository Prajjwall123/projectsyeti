import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String notificationId;
  final String recipient;
  final String recipientType;
  final String message;
  final bool isRead;
  final DateTime createdAt;

  const NotificationEntity({
    required this.notificationId,
    required this.recipient,
    required this.recipientType,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  NotificationEntity copyWith({
    String? notificationId,
    String? recipient,
    String? recipientType,
    String? message,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationEntity(
      notificationId: notificationId ?? this.notificationId,
      recipient: recipient ?? this.recipient,
      recipientType: recipientType ?? this.recipientType,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
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
