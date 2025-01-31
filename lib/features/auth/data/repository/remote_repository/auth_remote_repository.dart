import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:projectsyeti/features/auth/domain/entity/auth_entity.dart';
import 'package:projectsyeti/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    debugPrint(email);
    try {
      debugPrint("calling for token");
      final token = await _authRemoteDataSource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      //
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      await _authRemoteDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDataSource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
