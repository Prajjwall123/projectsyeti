import 'package:projectsyeti/features/wallet/domain/entity/wallet_entity.dart';

abstract interface class IWalletDataSource {
  Future<WalletEntity> getWalletAmount(String walletId);
}
