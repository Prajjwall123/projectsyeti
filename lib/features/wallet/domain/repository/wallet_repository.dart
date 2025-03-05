import 'package:dartz/dartz.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/wallet/domain/entity/wallet_entity.dart';

abstract interface class IWalletRepository {
  Future<Either<Failure, WalletEntity>> getWalletAmount(String walletId);
}
