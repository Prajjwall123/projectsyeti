import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/bidding_entity.dart';

abstract interface class IBiddingRepository {
  Future<Either<Failure, void>> createBid(BiddingEntity bid, File file);
}
