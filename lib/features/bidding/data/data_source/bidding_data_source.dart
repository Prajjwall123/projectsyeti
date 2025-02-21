import 'dart:io';

import '../../domain/entity/bidding_entity.dart';

abstract interface class IBiddingDataSource {
  Future<void> createBid(BiddingEntity bid, File file);
}
