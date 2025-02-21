import 'package:dartz/dartz.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';

abstract interface class IFreelancerRepository {
  Future<Either<Failure, FreelancerEntity>> getFreelancerById(String id);
  Future<Either<Failure, FreelancerEntity>> updateFreelancerById(
      String id, FreelancerEntity freelancer);
}
