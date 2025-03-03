import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/project/domain/repository/project_repository.dart';
import '../entity/project_entity.dart';

class GetProjectsByFreelancerIdParams extends Equatable {
  final String freelancerId;

  const GetProjectsByFreelancerIdParams({required this.freelancerId});

  @override
  List<Object?> get props => [freelancerId];
}

class GetProjectsByFreelancerIdUsecase
    implements
        UsecaseWithIdParams<ProjectEntity, GetProjectsByFreelancerIdParams> {
  final IProjectRepository projectRepository;

  GetProjectsByFreelancerIdUsecase({required this.projectRepository});

  @override
  Future<Either<Failure, List<ProjectEntity>>> call(
      GetProjectsByFreelancerIdParams params) async {
    return await projectRepository
        .getProjectsByFreelancerId(params.freelancerId);
  }
}
