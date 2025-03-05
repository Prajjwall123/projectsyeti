import 'package:projectsyeti/features/notification/domain/entity/notification_entity.dart';

final DateTime testDate = DateTime(2025, 3, 3);

final NotificationEntity notification1 = NotificationEntity(
  notificationId: 'notification1',
  recipient: 'freelancerTest',
  recipientType: 'freelancer',
  message:
      "Feedback received on project: 'AI-Powered Resume Screening System!'",
  isRead: false,
  createdAt: testDate,
);

final NotificationEntity notification2 = NotificationEntity(
  notificationId: 'notification2',
  recipient: 'freelancerTest',
  recipientType: 'freelancer',
  message:
      "Feedback received on project: 'AI-Powered Resume Screening System!'",
  isRead: true,
  createdAt: testDate,
);

final List<NotificationEntity> notifications = [notification1, notification2];
