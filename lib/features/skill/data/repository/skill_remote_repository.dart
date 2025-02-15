import 'package:dartz/dartz.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/skill/data/data_source/remote_data_source/skill_remote_data_source.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/skill/domain/repository/skill_repository.dart';

class SkillRemoteRepository implements ISkillRepository {
  final SkillRemoteDataSource _skillRemoteDataSource;

  SkillRemoteRepository(this._skillRemoteDataSource);

  @override
  Future<Either<Failure, List<SkillEntity>>> getSkills() async {
    try {
      final skills = await _skillRemoteDataSource.getSkills();
      return Right(skills);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SkillEntity>> getSkillById(String skillId) async {
    try {
      final skill = await _skillRemoteDataSource.getSkillById(skillId);
      return Right(skill);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
