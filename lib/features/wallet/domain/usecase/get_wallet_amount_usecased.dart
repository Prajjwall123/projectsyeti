import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/wallet/domain/entity/wallet_entity.dart';
import 'package:projectsyeti/features/wallet/domain/repository/wallet_repository.dart';

class GetWalletAmountParams extends Equatable {
  final String walletId;

  const GetWalletAmountParams({required this.walletId});

  @override
  List<Object?> get props => [walletId];
}

class GetWalletAmountUsecase
    implements UsecaseWithParams<WalletEntity, GetWalletAmountParams> {
  final IWalletRepository _walletRepository;

  GetWalletAmountUsecase({required IWalletRepository walletRepository})
      : _walletRepository = walletRepository;

  @override
  Future<Either<Failure, WalletEntity>> call(GetWalletAmountParams params) {
    return _walletRepository.getWalletAmount(params.walletId);
  }
}
