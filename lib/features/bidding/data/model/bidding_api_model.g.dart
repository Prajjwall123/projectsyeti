// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bidding_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiddingApiModel _$BiddingApiModelFromJson(Map<String, dynamic> json) =>
    BiddingApiModel(
      id: json['_id'] as String?,
      freelancerId: json['freelancerId'] as String,
      projectId: json['projectId'] as String,
      amount: (json['amount'] as num).toDouble(),
      message: json['message'] as String,
      fileName: json['fileName'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BiddingApiModelToJson(BiddingApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'freelancerId': instance.freelancerId,
      'projectId': instance.projectId,
      'amount': instance.amount,
      'message': instance.message,
      'fileName': instance.fileName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
