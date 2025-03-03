import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/bidding/domain/usecase/create_bid_usecase.dart';
import 'package:projectsyeti/features/bidding/presentation/viewmodel/bidding_bloc.dart';

class MockCreateBidUseCase extends Mock implements CreateBidUseCase {}

void main() {
  late CreateBidUseCase mockCreateBidUseCase;
  late BiddingBloc biddingBloc;

  // Test data
  const tFreelancer = 'f1';
  const tProject = 'p1';
  const tAmount = 1000.0;
  const tMessage = 'Test bid message';
  final tFile = File('test.pdf');
  const tFailure = ApiFailure(message: 'Something went wrong');

  setUp(() {
    mockCreateBidUseCase = MockCreateBidUseCase();
    biddingBloc = BiddingBloc(createBidUsecase: mockCreateBidUseCase);

    // Register fallbacks
    registerFallbackValue(CreateBidParams(
      freelancer: 'fake',
      project: 'fake',
      amount: 0.0,
      message: 'fake',
      file: File('fake'),
    ));
  });

  blocTest<BiddingBloc, BiddingState>(
    'emits [BiddingState] with loading and success when CreateBid succeeds',
    build: () {
      when(() => mockCreateBidUseCase(any()))
          .thenAnswer((_) async => const Right(null));
      return biddingBloc;
    },
    act: (bloc) => bloc.add(CreateBidEvent(
      freelancer: tFreelancer,
      project: tProject,
      amount: tAmount,
      message: tMessage,
      file: tFile,
    )),
    expect: () => [
      BiddingState.initial().copyWith(isLoading: true),
      BiddingState.initial().copyWith(isLoading: false),
    ],
    verify: (_) {
      verify(() => mockCreateBidUseCase(any())).called(1);
    },
  );

  blocTest<BiddingBloc, BiddingState>(
    'emits [BiddingState] with success when CreateBid succeeds with skip 1',
    build: () {
      when(() => mockCreateBidUseCase(any()))
          .thenAnswer((_) async => const Right(null));
      return biddingBloc;
    },
    act: (bloc) => bloc.add(CreateBidEvent(
      freelancer: tFreelancer,
      project: tProject,
      amount: tAmount,
      message: tMessage,
      file: tFile,
    )),
    skip: 1,
    expect: () => [
      BiddingState.initial().copyWith(isLoading: false),
    ],
    verify: (_) {
      verify(() => mockCreateBidUseCase(any())).called(1);
    },
  );

  blocTest<BiddingBloc, BiddingState>(
    'emits [BiddingState] with error when CreateBid fails',
    build: () {
      when(() => mockCreateBidUseCase(any()))
          .thenAnswer((_) async => const Left(tFailure));
      return biddingBloc;
    },
    act: (bloc) => bloc.add(CreateBidEvent(
      freelancer: tFreelancer,
      project: tProject,
      amount: tAmount,
      message: tMessage,
      file: tFile,
    )),
    expect: () => [
      BiddingState.initial().copyWith(isLoading: true),
      BiddingState.initial().copyWith(
        isLoading: false,
        error: tFailure.message,
      ),
    ],
    verify: (_) {
      verify(() => mockCreateBidUseCase(any())).called(1);
    },
  );
}
