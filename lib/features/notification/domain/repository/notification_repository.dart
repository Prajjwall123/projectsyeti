import 'package:dartz/dartz.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/notification/domain/entity/notification_entity.dart';

abstract interface class INotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>>
      getNotificationByFreelancerId(String freelancerId);
  Future<Either<Failure, NotificationEntity>> seenNotificationByFreelancerId(
      String notificationId);
}
