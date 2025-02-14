import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:projectsyeti/app/usecase/usecase.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/skill/domain/repository/skill_repository.dart';

class GetSkillByIdParams extends Equatable {
  final String skillId;

  const GetSkillByIdParams({required this.skillId});

  @override
  List<Object?> get props => [skillId];
}

class GetSkillByIdUsecase
    implements UsecaseWithParams<SkillEntity, GetSkillByIdParams> {
  final ISkillRepository _skillRepository;

  GetSkillByIdUsecase({required ISkillRepository skillRepository})
      : _skillRepository = skillRepository;

  @override
  Future<Either<Failure, SkillEntity>> call(GetSkillByIdParams params) {
    return _skillRepository.getSkillById(params.skillId);
  }
}
