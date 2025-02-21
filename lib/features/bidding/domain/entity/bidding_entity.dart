import 'package:equatable/equatable.dart';

class BiddingEntity extends Equatable {
  final String? id;
  final String freelancerId;
  final String projectId;
  final double amount;
  final String message;
  final String fileName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BiddingEntity({
    this.id,
    required this.freelancerId,
    required this.projectId,
    required this.amount,
    required this.message,
    required this.fileName,
    this.createdAt,
    this.updatedAt,
  });

  BiddingEntity.empty()
      : id = '',
        freelancerId = '',
        projectId = '',
        amount = 0.0,
        message = '',
        fileName = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  @override
  List<Object?> get props => [
        id,
        freelancerId,
        projectId,
        amount,
        message,
        fileName,
        createdAt,
        updatedAt,
      ];
}
