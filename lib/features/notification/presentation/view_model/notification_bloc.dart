import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/notification/domain/entity/notification_entity.dart';
import 'package:projectsyeti/features/notification/domain/usecase/get_notification_by_freelancer_id_usecase.dart';
import 'package:projectsyeti/features/notification/domain/usecase/seen_notification_by_freelancer_id_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationByFreelancerIdUsecase _getNotificationsUsecase;
  final SeenNotificationByFreelancerIdUsecase _seenNotificationUsecase;

  NotificationBloc({
    required GetNotificationByFreelancerIdUsecase getNotificationsUsecase,
    required SeenNotificationByFreelancerIdUsecase seenNotificationUsecase,
  })  : _getNotificationsUsecase = getNotificationsUsecase,
        _seenNotificationUsecase = seenNotificationUsecase,
        super(NotificationInitial()) {
    on<GetNotificationByFreelancerIdEvent>(_onGetNotifications);
    on<SeenNotificationEvent>(_onSeenNotification);
  }

  Future<void> _onGetNotifications(
    GetNotificationByFreelancerIdEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    final Either<Failure, List<NotificationEntity>> result =
        await _getNotificationsUsecase(
      GetNotificationByFreelancerIdParams(freelancerId: event.freelancerId),
    );

    result.fold(
      (failure) => emit(
          NotificationError(failure.message ?? "Error fetching notifications")),
      (notifications) => emit(NotificationLoaded(notifications)),
    );
  }

  Future<void> _onSeenNotification(
    SeenNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    final Either<Failure, NotificationEntity> result =
        await _seenNotificationUsecase(
      SeenNotificationByFreelancerIdParams(
          notificationId: event.notificationId),
    );

    result.fold(
      (failure) => emit(
          NotificationError(failure.message ?? "Error updating notification")),
      (notification) => emit(NotificationSeenSuccess(notification)),
    );
  }
}
