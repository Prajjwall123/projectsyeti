import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/wallet/domain/entity/wallet_entity.dart';

part 'wallet_api_model.g.dart';

@JsonSerializable()
class WalletApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? walletId;
  final int amount;

  const WalletApiModel({
    this.walletId,
    required this.amount,
  });

  factory WalletApiModel.fromJson(Map<String, dynamic> json) =>
      _$WalletApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletApiModelToJson(this);

  factory WalletApiModel.fromEntity(WalletEntity entity) {
    return WalletApiModel(
      walletId: entity.walletId,
      amount: entity.amount,
    );
  }

  WalletEntity toEntity() {
    return WalletEntity(
      walletId: walletId,
      amount: amount,
    );
  }

  static List<WalletEntity> toEntityList(List<WalletApiModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }

  static List<WalletApiModel> fromEntityList(List<WalletEntity> entityList) {
    return entityList
        .map((entity) => WalletApiModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [walletId, amount];
}
