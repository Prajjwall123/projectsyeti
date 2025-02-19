import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/freelancer/domain/repository/freelancer_repository.dart';
import '../entity/freelancer_entity.dart';

class GetFreelancerByIdParams extends Equatable {
  final String freelancerId;

  const GetFreelancerByIdParams({required this.freelancerId});

  @override
  List<Object?> get props => [freelancerId];
}

class GetFreelancerByIdUsecase
    implements UsecaseWithParams<FreelancerEntity, GetFreelancerByIdParams> {
  final IFreelancerRepository freelancerRepository;

  GetFreelancerByIdUsecase({required this.freelancerRepository});

  @override
  Future<Either<Failure, FreelancerEntity>> call(
      GetFreelancerByIdParams params) async {
    return await freelancerRepository.getFreelancerById(params.freelancerId);
  }
}
