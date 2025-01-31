import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/core/common/snackbar/my_snackbar.dart';
import 'package:projectsyeti/features/auth/domain/use_case/register_usecase.dart';
import 'package:projectsyeti/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/skill/presentation/view_model/bloc/skill_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SkillBloc _skillBloc;
  final UploadImageUsecase _uploadImageUsecase;
  final RegisterUseCase _registerUseCase;

  RegisterBloc({
    required SkillBloc skillBloc,
    required UploadImageUsecase uploadImageUsecase,
    required RegisterUseCase registerUseCase,
  })  : _skillBloc = skillBloc,
        _registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(RegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);
    on<UploadImage>(_onUploadImage);
    on<FetchSkills>(_onFetchSkills);

    add(FetchSkills());
  }

  void _onFetchSkills(
    FetchSkills event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(isLoading: true));

    // Dispatch LoadSkills event from SkillBloc
    _skillBloc.add(LoadSkills()); // ✅ This now works correctly

    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
      freelancerName: event.freelancerName,
      portfolio: event.portfolio,
      email: event.email,
      skills: event.skills,
      availability: event.availability,
      experienceYears: event.experienceYears,
      password: event.password,
      profileImage: event.profileImage,
    ));

    result.fold(
      (l) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
            context: event.context, message: l.message, color: Colors.red);
      },
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
      },
    );
  }

  void _onUploadImage(
    UploadImage event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(
        file: event.file,
      ),
    );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }
}
