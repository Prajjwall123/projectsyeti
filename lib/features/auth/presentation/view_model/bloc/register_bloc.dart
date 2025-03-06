import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/core/common/snackbar/my_snackbar.dart';
import 'package:projectsyeti/features/auth/domain/use_case/register_usecase.dart';
import 'package:projectsyeti/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:projectsyeti/features/auth/domain/use_case/verify_otp_usecase.dart';
import 'package:projectsyeti/features/auth/presentation/view/otp_view.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/skill/presentation/view_model/bloc/skill_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SkillBloc _skillBloc;
  final UploadImageUsecase _uploadImageUsecase;
  final RegisterUseCase _registerUseCase;
  final VerifyOtpUsecase _verifyOtpUsecase;

  RegisterBloc({
    required SkillBloc skillBloc,
    required UploadImageUsecase uploadImageUsecase,
    required RegisterUseCase registerUseCase,
    required VerifyOtpUsecase verifyOtpUsecase,
  })  : _skillBloc = skillBloc,
        _registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        _verifyOtpUsecase = verifyOtpUsecase,
        super(RegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);
    on<UploadImage>(_onUploadImage);
    on<FetchSkills>(_onFetchSkills);
    on<VerifyOtp>(_onVerifyOtp);

    add(FetchSkills());
  }

  void _onFetchSkills(
    FetchSkills event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(isLoading: true));

    _skillBloc.add(LoadSkills());

    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _registerUseCase.call(RegisterUserParams(
      freelancerName: event.freelancerName,
      email: event.email,
      skills: event.skills,
      password: event.password,
      profileImage: state.profileImage ?? "",
    ));

    result.fold(
      (l) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: l.message,
          color: Colors.red,
        );
      },
      (r) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          email: event.email,
        ));
        showMySnackBar(
          context: event.context,
          message: "Registration successful",
          color: Colors.green,
        );

        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => OtpView(email: event.email),
          ),
        );
      },
    );
  }

  void _onVerifyOtp(
    VerifyOtp event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _verifyOtpUsecase.call(
      VerifyOtpParams(
        email: event.email,
        otp: event.otp,
      ),
    );

    result.fold(
      (l) {
        emit(state.copyWith(isLoading: false, isOtpVerified: false));
        showMySnackBar(
          context: event.context,
          message: "OTP Verified Successfully",
          color: Colors.green,
        );
        Navigator.pushReplacementNamed(event.context, '/login');
      },
      (r) {
        emit(state.copyWith(isLoading: false, isOtpVerified: true));
        showMySnackBar(
            context: event.context,
            color: Colors.red,
            message: "OTP is incorrect");
      },
    );
  }

  void _onUploadImage(
    UploadImage event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _uploadImageUsecase.call(
      UploadImageParams(file: event.file),
    );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (imageUrl) {
        debugPrint(imageUrl);
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          profileImage: imageUrl,
        ));
      },
    );
  }
}
