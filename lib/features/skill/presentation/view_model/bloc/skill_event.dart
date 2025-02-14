part of 'skill_bloc.dart';

sealed class SkillEvent extends Equatable {
  const SkillEvent();

  @override
  List<Object?> get props => [];
}

class LoadSkills extends SkillEvent {}

class GetSkillByIdEvent extends SkillEvent {
  final String skillId;

  const GetSkillByIdEvent(this.skillId);

  @override
  List<Object?> get props => [skillId];
}
