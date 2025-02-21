import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:projectsyeti/features/bidding/domain/entity/bidding_entity.dart';

part 'bidding_api_model.g.dart';

@JsonSerializable()
class BiddingApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String freelancerId;
  final String projectId;
  final double amount;
  final String message;
  final String fileName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BiddingApiModel({
    this.id,
    required this.freelancerId,
    required this.projectId,
    required this.amount,
    required this.message,
    required this.fileName,
     this.createdAt,
     this.updatedAt,
  });

  factory BiddingApiModel.fromJson(Map<String, dynamic> json) =>
      _$BiddingApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$BiddingApiModelToJson(this);

  // To Entity
  BiddingEntity toEntity() {
    return BiddingEntity(
      id: id ?? '',
      freelancerId: freelancerId,
      projectId: projectId,
      amount: amount,
      message: message,
      fileName: fileName,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // From Entity
  factory BiddingApiModel.fromEntity(BiddingEntity entity) {
    return BiddingApiModel(
      id: entity.id,
      freelancerId: entity.freelancerId,
      projectId: entity.projectId,
      amount: entity.amount,
      message: entity.message,
      fileName: entity.fileName,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        freelancerId,
        projectId,
        amount,
        message,
        fileName,
        createdAt,
        updatedAt
      ];
}
