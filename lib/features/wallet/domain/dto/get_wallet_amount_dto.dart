import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/wallet/data/model/wallet_api_model.dart';

part 'get_wallet_amount_dto.g.dart';

@JsonSerializable()
class GetWalletAmountDTO {
  final WalletApiModel wallet;

  GetWalletAmountDTO({
    required this.wallet,
  });

  factory GetWalletAmountDTO.fromJson(Map<String, dynamic> json) =>
      _$GetWalletAmountDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetWalletAmountDTOToJson(this);
}
