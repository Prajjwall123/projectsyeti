import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/freelancer/domain/usecase/get_freelancer_by_id_usecase.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

part 'freelancer_event.dart';
part 'freelancer_state.dart';

class FreelancerBloc extends Bloc<FreelancerEvent, FreelancerState> {
  final GetFreelancerByIdUsecase _getFreelancerByIdUsecase;

  FreelancerBloc({
    required GetFreelancerByIdUsecase getFreelancerByIdUsecase,
  })  : _getFreelancerByIdUsecase = getFreelancerByIdUsecase,
        super(FreelancerInitial()) {
    on<GetFreelancerByIdEvent>(_onGetFreelancerById);
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
        // Directly map the skills from the freelancer entity
        List<SkillEntity> skillEntities = freelancer.skills;

        // Update the freelancer entity with skills
        final updatedFreelancer = freelancer.copyWith(skills: skillEntities);

        emit(FreelancerLoaded(updatedFreelancer));
      },
    );
  }
}
