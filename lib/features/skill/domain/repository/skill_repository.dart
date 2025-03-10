import 'package:dartz/dartz.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

abstract interface class ISkillRepository {
  Future<Either<Failure, List<SkillEntity>>> getSkills();

  Future<Either<Failure, SkillEntity>> getSkillById(String skillId);
}
