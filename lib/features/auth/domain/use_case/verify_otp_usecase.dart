import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:projectsyeti/features/auth/domain/repository/auth_repository.dart';

class VerifyOtpParams extends Equatable {
  final String email;
  final String otp;

  const VerifyOtpParams({
    required this.email,
    required this.otp,
  });

  // Empty constructor
  const VerifyOtpParams.empty()
      : email = '_empty.email',
        otp = '_empty.otp';

  @override
  List<Object?> get props => [email, otp];
}

class VerifyOtpUsecase implements UsecaseWithParams<bool, VerifyOtpParams> {
  final IAuthRepository authRepository;

  VerifyOtpUsecase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(VerifyOtpParams params) async {
    return await authRepository.verifyOtp(params.email, params.otp);
  }
}
