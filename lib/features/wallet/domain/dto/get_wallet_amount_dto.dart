import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/wallet/data/model/wallet_api_model.dart';

part 'get_wallet_amount_dto.g.dart';

@JsonSerializable()
class GetWalletAmountDTO {
  @JsonKey(name: 'amount')
  final int balance;

  GetWalletAmountDTO({
    required this.balance,
  });

  factory GetWalletAmountDTO.fromJson(Map<String, dynamic> json) =>
      _$GetWalletAmountDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetWalletAmountDTOToJson(this);

  WalletApiModel toWalletApiModel() {
    return WalletApiModel(amount: balance);
  }
}
