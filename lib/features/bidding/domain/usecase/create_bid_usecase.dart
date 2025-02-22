import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/freelancer/domain/repository/freelancer_repository.dart';
import '../entity/bidding_entity.dart';
import '../repository/bidding_repository.dart';

class CreateBidUseCase implements UsecaseWithParams<void, CreateBidParams> {
  final IBiddingRepository repository;

  CreateBidUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateBidParams params) {
    final biddingEntity = BiddingEntity(
      freelancerId: params.freelancer,
      projectId: params.project,
      amount: params.amount,
      message: params.message,
      fileName: '',
    );

    return repository.createBid(biddingEntity, params.file).then((value) {
      return value.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    });
  }
}

class CreateBidParams {
  final String freelancer;
  final String project;
  final double amount;
  final String message;
  final File file;

  CreateBidParams({
    required this.freelancer,
    required this.project,
    required this.amount,
    required this.message,
    required this.file,
  });

  CreateBidParams.initial()
      : freelancer = '',
        project = '',
        amount = 0.0,
        message = '',
        file = File('');

  List<Object?> get props => [freelancer, project, amount, message, file];
}
