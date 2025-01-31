import 'package:dartz/dartz.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/auth/domain/repository/auth_repository.dart';

class VerifyOtpParams {
  final String email;
  final String otp;

  const VerifyOtpParams({
    required this.email,
    required this.otp,
  });
}

class VerifyOtpUsecase implements UsecaseWithParams<bool, VerifyOtpParams> {
  final IAuthRepository _repository;

  VerifyOtpUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> call(VerifyOtpParams params) {
    return _repository.verifyOtp(params.email, params.otp);
  }
}
