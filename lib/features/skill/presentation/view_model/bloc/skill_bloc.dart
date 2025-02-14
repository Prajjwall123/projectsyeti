import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/skill/domain/use_case/get_all_skills_usecase.dart';
import 'package:projectsyeti/features/skill/domain/use_case/get_skill_by_id_usecase.dart';

part 'skill_event.dart';
part 'skill_state.dart';

class SkillBloc extends Bloc<SkillEvent, SkillState> {
  final GetAllSkillsUsecase _getAllSkillsUsecase;
  final GetSkillByIdUsecase _getSkillByIdUsecase;

  SkillBloc({
    required GetAllSkillsUsecase getAllSkillsUsecase,
    required GetSkillByIdUsecase getSkillByIdUsecase,
  })  : _getAllSkillsUsecase = getAllSkillsUsecase,
        _getSkillByIdUsecase = getSkillByIdUsecase,
        super(SkillState.initial()) {
    on<LoadSkills>(_onLoadSkills);
    on<GetSkillByIdEvent>(_onGetSkillById);

    add(LoadSkills());
  }

  Future<void> _onLoadSkills(LoadSkills event, Emitter<SkillState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllSkillsUsecase.call();

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (skills) => emit(state.copyWith(isLoading: false, skills: skills)),
    );
  }

  Future<void> _onGetSkillById(
      GetSkillByIdEvent event, Emitter<SkillState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getSkillByIdUsecase
        .call(GetSkillByIdParams(skillId: event.skillId));

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (skill) => emit(state.copyWith(isLoading: false, selectedSkill: skill)),
    );
  }
}
