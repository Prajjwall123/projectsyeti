// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_wallet_amount_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWalletAmountDTO _$GetWalletAmountDTOFromJson(Map<String, dynamic> json) =>
    GetWalletAmountDTO(
      wallet: WalletApiModel.fromJson(json['wallet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetWalletAmountDTOToJson(GetWalletAmountDTO instance) =>
    <String, dynamic>{
      'wallet': instance.wallet,
    };
