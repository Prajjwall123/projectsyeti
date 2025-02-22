// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_notification_by_freelancer_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNotificationByFreelancerIdDTO _$GetNotificationByFreelancerIdDTOFromJson(
        Map<String, dynamic> json) =>
    GetNotificationByFreelancerIdDTO(
      id: json['id'] as String,
      recipient: json['recipient'] as String,
      recipientType: json['recipientType'] as String,
      message: json['message'] as String,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$GetNotificationByFreelancerIdDTOToJson(
        GetNotificationByFreelancerIdDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipient': instance.recipient,
      'recipientType': instance.recipientType,
      'message': instance.message,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
    };
