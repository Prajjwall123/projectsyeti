import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/notification/domain/entity/notification_entity.dart';
import 'package:projectsyeti/features/notification/domain/repository/notification_repository.dart';

class SeenNotificationByFreelancerIdParams extends Equatable {
  final String notificationId;

  const SeenNotificationByFreelancerIdParams({required this.notificationId});

  @override
  List<Object?> get props => [notificationId];
}

class SeenNotificationByFreelancerIdUsecase
    implements UsecaseWithParams<String, SeenNotificationByFreelancerIdParams> {
  final INotificationRepository notificationRepository;

  SeenNotificationByFreelancerIdUsecase({required this.notificationRepository});

  @override
  Future<Either<Failure, String>> call(
      SeenNotificationByFreelancerIdParams params) async {
    return await notificationRepository
        .seenNotificationByFreelancerId(params.notificationId);
  }
}
