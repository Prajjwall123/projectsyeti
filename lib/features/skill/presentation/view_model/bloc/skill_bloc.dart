import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/skill/domain/use_case/get_all_skills_usecase.dart';

part 'skill_event.dart';
part 'skill_state.dart';

class SkillBloc extends Bloc<SkillEvent, SkillState> {
  final GetAllSkillsUsecase _getAllSkillsUsecase;

  SkillBloc({
    required GetAllSkillsUsecase getAllSkillsUsecase,
  })  : _getAllSkillsUsecase = getAllSkillsUsecase,
        super(SkillState.initial()) {
    on<LoadSkills>(_onLoadSkills);
  }

  Future<void> _onLoadSkills(LoadSkills event, Emitter<SkillState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllSkillsUsecase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) => emit(state.copyWith(isLoading: false, batches: batches)),
    );
  }
}
