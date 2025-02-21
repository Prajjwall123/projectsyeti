import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/bidding/data/data_source/remote_data_source/bidding_remote_data_source.dart';
import 'package:projectsyeti/features/bidding/domain/entity/bidding_entity.dart';
import 'package:projectsyeti/features/bidding/domain/repository/bidding_repository.dart';

class BiddingRemoteRepository implements IBiddingRepository {
  final BiddingRemoteDataSource _biddingRemoteDataSource;

  BiddingRemoteRepository(this._biddingRemoteDataSource);

  @override
  Future<Either<Failure, void>> createBid(BiddingEntity bid, File file) async {
    try {
      // Pass both the bid and the file to the data source
      await _biddingRemoteDataSource.createBid(bid, file);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
