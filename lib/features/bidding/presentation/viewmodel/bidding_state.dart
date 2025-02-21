part of 'bidding_bloc.dart';

class BiddingState extends Equatable {
  final bool isLoading;
  final String? error;
  final bool? success;

  const BiddingState({
    required this.isLoading,
    this.error,
    this.success,
  });

  factory BiddingState.initial() {
    return const BiddingState(
      isLoading: false,
      error: null,
      success: null,
    );
  }

  BiddingState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
  }) {
    return BiddingState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, success];
}
