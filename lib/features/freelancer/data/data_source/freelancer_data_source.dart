import 'package:dartz/dartz.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';

abstract interface class IFreelancerDataSource {
  Future<FreelancerEntity> getFreelancerById(String id);
  Future<FreelancerEntity> updateFreelancerById(
      String id, FreelancerEntity freelancer);
}
