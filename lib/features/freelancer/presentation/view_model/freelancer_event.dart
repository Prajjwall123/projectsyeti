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

class UpdateFreelancerEvent extends FreelancerEvent {
  final FreelancerEntity freelancer;

  const UpdateFreelancerEvent(this.freelancer);

  @override
  List<Object?> get props => [freelancer];
}

class UploadFreelancerImageEvent extends FreelancerEvent {
  final File file;

  const UploadFreelancerImageEvent(this.file);

  @override
  List<Object?> get props => [file];
}
