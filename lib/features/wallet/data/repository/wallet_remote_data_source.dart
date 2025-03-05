import 'package:dartz/dartz.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/wallet/data/model/data_source/remote_data_source/wallet_remote_data_source.dart';
import 'package:projectsyeti/features/wallet/domain/entity/wallet_entity.dart';
import 'package:projectsyeti/features/wallet/domain/repository/wallet_repository.dart';

class WalletRemoteRepository implements IWalletRepository {
  final WalletRemoteDataSource _walletRemoteDataSource;

  WalletRemoteRepository(this._walletRemoteDataSource);

  @override
  Future<Either<Failure, WalletEntity>> getWalletAmount(String walletId) async {
    try {
      final wallet = await _walletRemoteDataSource.getWalletAmount(walletId);
      return Right(wallet);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
