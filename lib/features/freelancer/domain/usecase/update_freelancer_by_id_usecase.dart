import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/freelancer/domain/repository/freelancer_repository.dart';

class UpdateFreelancerByIdParams extends Equatable {
  final String freelancerId;
  final FreelancerEntity freelancer;

  const UpdateFreelancerByIdParams({
    required this.freelancerId,
    required this.freelancer,
  });

  @override
  List<Object?> get props => [freelancerId, freelancer];
}

class UpdateFreelancerByIdUsecase
    implements UsecaseWithParams<FreelancerEntity, UpdateFreelancerByIdParams> {
  final IFreelancerRepository freelancerRepository;

  UpdateFreelancerByIdUsecase({required this.freelancerRepository});

  @override
  Future<Either<Failure, FreelancerEntity>> call(
      UpdateFreelancerByIdParams params) async {
    return await freelancerRepository.updateFreelancerById(
        params.freelancerId, params.freelancer);
  }
}
