import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/features/bidding/domain/usecase/create_bid_usecase.dart';
import 'dart:io'; // Import File

part 'bidding_event.dart';
part 'bidding_state.dart';

class BiddingBloc extends Bloc<BiddingEvent, BiddingState> {
  final CreateBidUseCase _createBidUsecase;

  BiddingBloc({required CreateBidUseCase createBidUsecase})
      : _createBidUsecase = createBidUsecase,
        super(BiddingState.initial()) {
    on<CreateBidEvent>(_onCreateBid);
  }

  Future<void> _onCreateBid(
      CreateBidEvent event, Emitter<BiddingState> emit) async {
    emit(state.copyWith(isLoading: true));

    // Pass the file along with other parameters
    final result = await _createBidUsecase.call(CreateBidParams(
      freelancer: event.freelancer,
      project: event.project,
      amount: event.amount,
      message: event.message,
      file: event.file, // Pass the file here
    ));

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => emit(state.copyWith(isLoading: false)),
    );
  }
}
