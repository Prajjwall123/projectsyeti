part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class GetNotificationByFreelancerIdEvent extends NotificationEvent {
  final String freelancerId;

  const GetNotificationByFreelancerIdEvent(this.freelancerId);

  @override
  List<Object?> get props => [freelancerId];
}

class SeenNotificationEvent extends NotificationEvent {
  final String notificationId;

  const SeenNotificationEvent(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}
