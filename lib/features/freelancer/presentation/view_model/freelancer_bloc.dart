import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/freelancer/domain/usecase/get_freelancer_by_id_usecase.dart';
import 'package:projectsyeti/features/freelancer/domain/usecase/update_freelancer_by_id_usecase.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

part 'freelancer_event.dart';
part 'freelancer_state.dart';

class FreelancerBloc extends Bloc<FreelancerEvent, FreelancerState> {
  final GetFreelancerByIdUsecase _getFreelancerByIdUsecase;
  final UpdateFreelancerByIdUsecase _updateFreelancerByIdUsecase;
  final UploadImageUsecase _uploadImageUsecase;

  FreelancerBloc({
    required GetFreelancerByIdUsecase getFreelancerByIdUsecase,
    required UpdateFreelancerByIdUsecase updateFreelancerByIdUsecase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _getFreelancerByIdUsecase = getFreelancerByIdUsecase,
        _updateFreelancerByIdUsecase = updateFreelancerByIdUsecase,
        _uploadImageUsecase = uploadImageUsecase,
        super(FreelancerInitial()) {
    on<GetFreelancerByIdEvent>(_onGetFreelancerById);
    on<UpdateFreelancerEvent>(_onUpdateFreelancer);
    on<UploadFreelancerImageEvent>(_onUploadFreelancerImage);
  }

  Future<void> _onGetFreelancerById(
    GetFreelancerByIdEvent event,
    Emitter<FreelancerState> emit,
  ) async {
    emit(FreelancerLoading());

    final Either<Failure, FreelancerEntity> result =
        await _getFreelancerByIdUsecase(
      GetFreelancerByIdParams(freelancerId: event.freelancerId),
    );

    result.fold(
      (failure) =>
          emit(FreelancerError(failure.message ?? "Error fetching freelancer")),
      (freelancer) {
        emit(FreelancerLoaded(freelancer));
      },
    );
  }

  Future<void> _onUpdateFreelancer(
    UpdateFreelancerEvent event,
    Emitter<FreelancerState> emit,
  ) async {
    emit(FreelancerLoading());

    String? imageUrl;
    final file = File(event.freelancer.profileImage);
    final imageResult = await _uploadImageUsecase(
      UploadImageParams(file: file),
    );
    imageResult.fold(
      (failure) {
        emit(FreelancerUpdateError(failure.message ?? "Error uploading image"));
        return;
      },
      (url) {
        imageUrl = url;
      },
    );

    final Either<Failure, FreelancerEntity> result =
        await _updateFreelancerByIdUsecase(
      UpdateFreelancerByIdParams(
        freelancerId: event.freelancer.id,
        freelancer: event.freelancer.copyWith(profileImage: imageUrl),
      ),
    );

    result.fold(
      (failure) => emit(
          FreelancerUpdateError(failure.message ?? "Error updating profile")),
      (freelancer) {
        emit(FreelancerUpdateSuccess(freelancer));
        emit(FreelancerLoaded(freelancer));
      },
    );
  }

  Future<void> _onUploadFreelancerImage(
    UploadFreelancerImageEvent event,
    Emitter<FreelancerState> emit,
  ) async {
    emit(FreelancerLoading());

    final result = await _uploadImageUsecase(
      UploadImageParams(file: event.file),
    );

    result.fold(
      (failure) {
        emit(FreelancerError(failure.message ?? "Error uploading image"));
      },
      (imageUrl) {
        emit(FreelancerImageUploaded(imageUrl));
      },
    );
  }
}
