import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/auth/domain/entity/auth_entity.dart';
import 'package:projectsyeti/features/auth/domain/repository/auth_repository.dart';
import 'package:projectsyeti/features/auth/domain/use_case/register_usecase.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class FakeAuthEntity extends Fake implements AuthEntity {}

void main() {
  late MockAuthRepository repository;
  late RegisterUseCase usecase;

  setUpAll(() {
    registerFallbackValue(FakeAuthEntity());
  });

  setUp(() {
    repository = MockAuthRepository();
    usecase = RegisterUseCase(repository);
  });

  test('should register user and return void on success', () async {
    // Arrange
    when(() => repository.registerUser(any())).thenAnswer(
      (_) async => const Right(null),
    );

    // Act
    final result = await usecase(const RegisterUserParams(
      freelancerName: "Prajwal Pokhrel",
      portfolio: "https://portfolio.com",
      profileImage: "image/10010-image.png",
      email: "pokhrelprajwal29@gmail.com",
      password: "password",
      skills: [SkillEntity(name: "Flutter")],
      availability: "Full-Time",
      experienceYears: 5,
    ));

    // Assert
    expect(result, const Right(null));

    // Verify
    verify(() => repository.registerUser(any())).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return Failure when repository fails', () async {
    // Arrange
    when(() => repository.registerUser(any())).thenAnswer(
      (_) async => const Left(ApiFailure(message: "user already esists")),
    );

    // Act
    final result = await usecase(const RegisterUserParams(
      freelancerName: "Prajwal Pokhrel",
      portfolio: "https://portfolio.com",
      profileImage: "image/10010-image.png",
      email: "pokhrelprajwal29@gmail.com",
      password: "password",
      skills: [SkillEntity(name: "Flutter")],
      availability: "Full-Time",
      experienceYears: 5,
    ));

    // Assert
    expect(result, isA<Left<Failure, void>>());

    // Verify
    verify(() => repository.registerUser(any())).called(1);
    verifyNoMoreInteractions(repository);
  });
}
