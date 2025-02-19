part of 'freelancer_bloc.dart';

sealed class FreelancerState extends Equatable {
  const FreelancerState();

  @override
  List<Object?> get props => [];
}

final class FreelancerInitial extends FreelancerState {}

final class FreelancerLoading extends FreelancerState {}

final class FreelancerLoaded extends FreelancerState {
  final FreelancerEntity freelancer;
  final List<SkillEntity> skills;

  const FreelancerLoaded(this.freelancer, {this.skills = const []});

  @override
  List<Object?> get props => [freelancer, skills];
}

final class FreelancerError extends FreelancerState {
  final String message;

  const FreelancerError(this.message);

  @override
  List<Object?> get props => [message];
}

final class FreelancerSkillsLoaded extends FreelancerState {
  final List<SkillEntity> skills;

  const FreelancerSkillsLoaded(this.skills);

  @override
  List<Object?> get props => [skills];
}
