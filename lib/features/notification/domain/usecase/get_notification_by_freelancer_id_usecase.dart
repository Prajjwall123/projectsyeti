import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/notification/domain/entity/notification_entity.dart';
import 'package:projectsyeti/features/notification/domain/repository/notification_repository.dart';

class GetNotificationByFreelancerIdParams extends Equatable {
  final String freelancerId;

  const GetNotificationByFreelancerIdParams({required this.freelancerId});

  @override
  List<Object?> get props => [freelancerId];
}

class GetNotificationByFreelancerIdUsecase
    implements
        UsecaseWithParams<List<NotificationEntity>,
            GetNotificationByFreelancerIdParams> {
  final INotificationRepository notificationRepository;

  GetNotificationByFreelancerIdUsecase({required this.notificationRepository});

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(
      GetNotificationByFreelancerIdParams params) async {
    return await notificationRepository
        .getNotificationByFreelancerId(params.freelancerId);
  }
}
