import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/skill/domain/use_case/get_all_skills_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockSkillRepository repository;
  late GetAllSkillsUsecase usecase;

  setUp(() {
    repository = MockSkillRepository();
    usecase = GetAllSkillsUsecase(skillRepository: repository);
  });

  const tSkill = SkillEntity(
    skillId: '1',
    name: 'Test Skill',
  );

  const tSkill2 = SkillEntity(
    skillId: '2',
    name: 'Test Skill 2',
  );

  final tSkills = [tSkill, tSkill2];

  test('should get all skills from repository', () async {
    when(() => repository.getSkills()).thenAnswer((_) async => Right(tSkills));

    final result = await usecase();

    expect(result, Right(tSkills));

    verify(() => repository.getSkills()).called(1);
  });

  test('should return a Failure when repository call fails', () async {
    const tFailure = ApiFailure(message: "Something went wrong");

    when(() => repository.getSkills())
        .thenAnswer((_) async => const Left(tFailure));

    final result = await usecase();

    expect(result, const Left(tFailure));

    verify(() => repository.getSkills()).called(1);
  });
}
