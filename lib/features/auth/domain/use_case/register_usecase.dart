import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String email;
  final String password;
  final String fname;
  final String phone;

  const RegisterUserParams({
    required this.email,
    required this.password,
    required this.fname,
    required this.phone,
  });

  const RegisterUserParams.initial()
      : email = '',
        password = '',
        fname = '',
        phone = '';

  @override
  List<Object?> get props => [email, password, fname, phone];
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
      fname: params.fname,
      phone: params.phone,
    );
    return repository.registerStudent(authEntity);
  }
}
