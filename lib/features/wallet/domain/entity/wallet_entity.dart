import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final String? walletId;
  final int amount;

  const WalletEntity({
    this.walletId,
    required this.amount,
  });

  @override
  List<Object?> get props => [walletId, amount];
}
