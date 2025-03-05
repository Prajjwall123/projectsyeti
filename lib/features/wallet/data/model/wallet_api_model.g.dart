// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletApiModel _$WalletApiModelFromJson(Map<String, dynamic> json) =>
    WalletApiModel(
      walletId: json['_id'] as String?,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$WalletApiModelToJson(WalletApiModel instance) =>
    <String, dynamic>{
      '_id': instance.walletId,
      'amount': instance.amount,
    };
