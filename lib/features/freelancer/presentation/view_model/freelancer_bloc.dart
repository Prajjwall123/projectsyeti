import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/freelancer/domain/usecase/get_freelancer_by_id_usecase.dart';
import 'package:projectsyeti/features/freelancer/domain/usecase/update_freelancer_by_id_usecase.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

part 'freelancer_event.dart';
part 'freelancer_state.dart';

class FreelancerBloc extends Bloc<FreelancerEvent, FreelancerState> {
  final GetFreelancerByIdUsecase _getFreelancerByIdUsecase;
  final UpdateFreelancerByIdUsecase _updateFreelancerByIdUsecase;

  FreelancerBloc({
    required GetFreelancerByIdUsecase getFreelancerByIdUsecase,
    required UpdateFreelancerByIdUsecase updateFreelancerByIdUsecase,
  })  : _getFreelancerByIdUsecase = getFreelancerByIdUsecase,
        _updateFreelancerByIdUsecase = updateFreelancerByIdUsecase,
        super(FreelancerInitial()) {
    on<GetFreelancerByIdEvent>(_onGetFreelancerById);
    on<UpdateFreelancerEvent>(_onUpdateFreelancer);
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
        emit(FreelancerLoaded(freelancer)); // Passing loaded freelancer data
      },
    );
  }

  Future<void> _onUpdateFreelancer(
    UpdateFreelancerEvent event,
    Emitter<FreelancerState> emit,
  ) async {
    emit(FreelancerLoading());

    final Either<Failure, FreelancerEntity> result =
        await _updateFreelancerByIdUsecase(
      UpdateFreelancerByIdParams(
        freelancerId: event.freelancer.id, // Ensure this is correctly passed
        freelancer:
            event.freelancer, // Ensure this is the updated FreelancerEntity
      ),
    );

    result.fold(
      (failure) => emit(
          FreelancerUpdateError(failure.message ?? "Error updating profile")),
      (freelancer) {
        emit(FreelancerUpdateSuccess(freelancer));
        emit(FreelancerLoaded(
            freelancer)); // Ensure the updated freelancer is displayed
      },
    );
  }
}
