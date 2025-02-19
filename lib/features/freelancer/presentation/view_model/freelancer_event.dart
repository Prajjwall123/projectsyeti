part of 'freelancer_bloc.dart';

sealed class FreelancerEvent extends Equatable {
  const FreelancerEvent();

  @override
  List<Object?> get props => [];
}

class GetFreelancerByIdEvent extends FreelancerEvent {
  final String freelancerId;

  const GetFreelancerByIdEvent(this.freelancerId);

  @override
  List<Object?> get props => [freelancerId];
}

// New event for fetching skills
class FetchSkills extends FreelancerEvent {}
