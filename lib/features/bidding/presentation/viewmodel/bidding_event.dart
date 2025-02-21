part of 'bidding_bloc.dart';

abstract class BiddingEvent extends Equatable {
  const BiddingEvent();

  @override
  List<Object> get props => [];
}

class CreateBidEvent extends BiddingEvent {
  final String freelancer;
  final String project;
  final double amount;
  final String message;
  final File file; 

  const CreateBidEvent({
    required this.freelancer,
    required this.project,
    required this.amount,
    required this.message,
    required this.file, 
  });

  @override
  List<Object> get props => [freelancer, project, amount, message, file];
}
