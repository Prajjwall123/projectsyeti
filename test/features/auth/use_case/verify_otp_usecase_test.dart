import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectsyeti/features/auth/domain/use_case/verify_otp_usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';

import 'repository.mock.dart';

void main() {
  late MockAuthRepository repository;
  late VerifyOtpUsecase usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = VerifyOtpUsecase(authRepository: repository);
  });

  const params = VerifyOtpParams.empty();

  test('should return true', () async {
    when(() => repository.verifyOtp(any(), any())).thenAnswer(
      (_) async => const Right(true),
    );

    final result = await usecase(params);

    expect(result, const Right(true));

    verify(() => repository.verifyOtp(params.email, params.otp)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return Failure when OTP verification fails', () async {
    const failure = ApiFailure(message: "incorrect OTP");
    when(() => repository.verifyOtp(any(), any())).thenAnswer(
      (_) async => const Left(failure),
    );

    final result = await usecase(params);

    expect(result, const Left(failure));

    verify(() => repository.verifyOtp(params.email, params.otp)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
