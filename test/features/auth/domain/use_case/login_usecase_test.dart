import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/auth/domain/use_case/login_usecase.dart';

import 'repository.mock.dart';
import 'token.mock.dart';

void main() {
  late MockAuthRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUseCase usecase;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    usecase = LoginUseCase(repository, tokenSharedPrefs);

    registerFallbackValue('mock_token');
  });

  const email = "testing@gmai.com";
  const password = "password123";
  const token = "token";
  const loginParams = LoginParams(email: email, password: password);

  test('should login user and save token on success', () async {
    // Arrange
    when(() => repository.loginUser(any(), any())).thenAnswer(
      (_) async => const Right(token),
    );
    when(() => tokenSharedPrefs.saveToken(any())).thenAnswer(
      (_) async => const Right(null),
    );
    when(() => tokenSharedPrefs.getToken()).thenAnswer(
      (_) async => const Right(token),
    );

    // Act
    final result = await usecase(loginParams);

    // Assert
    expect(result, const Right(token));

    // Verify repository and token handling
    verify(() => repository.loginUser(email, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(token)).called(1);
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  test('should return failure when login fails', () async {
    // Arrange
    when(() => repository.loginUser(any(), any())).thenAnswer(
      (_) async =>
          const Left(ApiFailure(message: 'Incorrect login creadentials')),
    );

    // Act
    final result = await usecase(loginParams);

    // Assert
    expect(
      result,
      const Left(ApiFailure(message: 'Incorrect login creadentials')),
    );

    verify(() => repository.loginUser(email, password)).called(1);
    verifyNever(() => tokenSharedPrefs.saveToken(any()));
    verifyNever(() => tokenSharedPrefs.getToken());
    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });
}
