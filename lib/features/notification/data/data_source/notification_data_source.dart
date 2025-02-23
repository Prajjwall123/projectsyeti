import 'package:projectsyeti/features/notification/domain/entity/notification_entity.dart';

abstract interface class INotificationDataSource {
  Future<List<NotificationEntity>> getNotificationByFreelancerId(
      String freelancerId);
  Future<String> seenNotificationByFreelancerId(
      String notificationId);
}
