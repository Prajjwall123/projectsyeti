import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/auth/domain/use_case/upload_image_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockAuthRepository repository;
  late UploadImageUsecase usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = UploadImageUsecase(repository);

    registerFallbackValue(File('test.jpg'));
  });

  final testFile = File('test.jpg');
  const testUrl = "images/1200-test.jpg";

  test('should upload image and return URL on success', () async {
    when(() => repository.uploadProfilePicture(any()))
        .thenAnswer((_) async => const Right(testUrl));

    final result = await usecase(UploadImageParams(file: testFile));

    expect(result, const Right(testUrl));
    verify(() => repository.uploadProfilePicture(testFile)).called(1);
  });

  test('should upload image and return URL on success', () async {
    const tFailure = ApiFailure(message: "Upload failed");
    when(() => repository.uploadProfilePicture(any()))
        .thenAnswer((_) async => const Left(tFailure));

    final result = await usecase(UploadImageParams(file: testFile));

    expect(result, const Right(testUrl));
    verify(() => repository.uploadProfilePicture(testFile)).called(1);
  });

  // test('should return a Failure when upload fails', () async {
  //   const tFailure = ApiFailure(message: "Upload failed");

  //   when(() => repository.uploadProfilePicture(any()))
  //       .thenAnswer((_) async => const Left(tFailure));

  //   final result = await usecase(UploadImageParams(file: testFile));

  //   expect(result, const Left(tFailure));
  //   verify(() => repository.uploadProfilePicture(testFile)).called(1);
  // });
}
