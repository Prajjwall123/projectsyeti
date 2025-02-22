import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/notification/data/data_source/remote_data_source/notification_remote_data_source.dart';
import 'package:projectsyeti/features/notification/domain/entity/notification_entity.dart';
import 'package:projectsyeti/features/notification/domain/repository/notification_repository.dart';

class NotificationRemoteRepository implements INotificationRepository {
  final NotificationRemoteDataSource _notificationRemoteDataSource;

  NotificationRemoteRepository(this._notificationRemoteDataSource);

  @override
  Future<Either<Failure, List<NotificationEntity>>>
      getNotificationByFreelancerId(String freelancerId) async {
    try {
      debugPrint(
          "Fetching notifications for freelancer with ID: $freelancerId");
      final notifications = await _notificationRemoteDataSource
          .getNotificationByFreelancerId(freelancerId);
      return Right(notifications);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NotificationEntity>> seenNotificationByFreelancerId(
      String notificationId) async {
    try {
      debugPrint(
          "Marking notification as seen for notification ID: $notificationId");
      final notification = await _notificationRemoteDataSource
          .seenNotificationByFreelancerId(notificationId);
      return Right(notification);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
