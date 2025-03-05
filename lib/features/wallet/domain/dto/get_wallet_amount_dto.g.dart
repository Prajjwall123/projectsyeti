// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_wallet_amount_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWalletAmountDTO _$GetWalletAmountDTOFromJson(Map<String, dynamic> json) =>
    GetWalletAmountDTO(
      balance: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$GetWalletAmountDTOToJson(GetWalletAmountDTO instance) =>
    <String, dynamic>{
      'amount': instance.balance,
    };
