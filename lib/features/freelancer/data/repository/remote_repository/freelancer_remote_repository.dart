import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/freelancer/data/data_source/remote_data_source/freelancer_remote_data_source.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/freelancer/domain/repository/freelancer_repository.dart';

class FreelancerRemoteRepository implements IFreelancerRepository {
  final FreelancerRemoteDataSource _freelancerRemoteDataSource;

  FreelancerRemoteRepository(this._freelancerRemoteDataSource);

  @override
  Future<Either<Failure, FreelancerEntity>> getFreelancerById(
      String freelancerId) async {
    try {
      debugPrint("Fetching freelancer with ID: $freelancerId");
      final freelancer =
          await _freelancerRemoteDataSource.getFreelancerById(freelancerId);
      return Right(freelancer);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FreelancerEntity>> updateFreelancerById(
      String id, FreelancerEntity freelancerEntity) async {
    try {
      debugPrint("updating freelancer with Id:$id");
      final freelancer = await _freelancerRemoteDataSource.updateFreelancerById(
          id, freelancerEntity);
      return Right(freelancer);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
