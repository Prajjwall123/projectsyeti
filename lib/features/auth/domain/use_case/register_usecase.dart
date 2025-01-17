import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String email;
  final String password;

  const RegisterUserParams({
    required this.email,
    required this.password,
  });

  const RegisterUserParams.initial()
      : email = '',
        password = '';

  @override
  List<Object?> get props => [email, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      id: null,
      email: params.email,
      password: params.password,
    );
    return repository.registerStudent(authEntity);
  }
}
