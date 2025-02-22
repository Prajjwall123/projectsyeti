// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seen_notification_by_freelancer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeenNotificationByFreelancerDTO _$SeenNotificationByFreelancerDTOFromJson(
        Map<String, dynamic> json) =>
    SeenNotificationByFreelancerDTO(
      id: json['id'] as String,
      isRead: json['isRead'] as bool,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$SeenNotificationByFreelancerDTOToJson(
        SeenNotificationByFreelancerDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isRead': instance.isRead,
      'updatedAt': instance.updatedAt,
    };
