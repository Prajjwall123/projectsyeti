import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:projectsyeti/features/skill/domain/use_case/get_all_skills_usecase.dart';
import 'package:projectsyeti/features/skill/domain/use_case/get_skill_by_id_usecase.dart';
import 'package:projectsyeti/features/skill/presentation/view_model/bloc/skill_bloc.dart';

class MockGetAllSkillsUsecase extends Mock implements GetAllSkillsUsecase {}

class MockGetSkillByIdUsecase extends Mock implements GetSkillByIdUsecase {}

void main() {
  late GetAllSkillsUsecase getAllSkillsUsecase;
  late GetSkillByIdUsecase getSkillByIdUsecase;
  late SkillBloc skillBloc;

  setUp(() {
    getAllSkillsUsecase = MockGetAllSkillsUsecase();
    getSkillByIdUsecase = MockGetSkillByIdUsecase();
    skillBloc = SkillBloc(
      getAllSkillsUsecase: getAllSkillsUsecase,
      getSkillByIdUsecase: getSkillByIdUsecase,
    );
    registerFallbackValue(SkillState.initial());
  });

  const skill1 = SkillEntity(skillId: '1', name: 'Flutter');
  const skill2 = SkillEntity(skillId: '2', name: 'Dart');
  final skillList = [skill1, skill2];

  blocTest<SkillBloc, SkillState>(
    'emits [SkillState] with loaded skills when LoadSkills is added',
    build: () {
      when(() => getAllSkillsUsecase.call())
          .thenAnswer((_) async => Right(skillList));
      return skillBloc;
    },
    act: (bloc) => bloc.add(LoadSkills()),
    expect: () => [
      SkillState.initial().copyWith(isLoading: true, error: null),
      SkillState.initial()
          .copyWith(isLoading: false, skills: skillList, error: null),
    ],
    verify: (_) {
      verify(() => getAllSkillsUsecase.call()).called(1);
    },
  );

  blocTest<SkillBloc, SkillState>(
    'emits [SkillState] with loaded skills when LoadSkills is added with skip 1',
    build: () {
      when(() => getAllSkillsUsecase.call())
          .thenAnswer((_) async => Right(skillList));
      return skillBloc;
    },
    act: (bloc) => bloc.add(LoadSkills()),
    skip: 1,
    expect: () => [
      SkillState.initial()
          .copyWith(isLoading: false, skills: skillList, error: null),
    ],
    verify: (_) {
      verify(() => getAllSkillsUsecase.call()).called(1);
    },
  );

  blocTest<SkillBloc, SkillState>(
    'emits [SkillState] with error when LoadSkills fails',
    build: () {
      when(() => getAllSkillsUsecase.call()).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Error loading skills')));
      return skillBloc;
    },
    act: (bloc) => bloc.add(LoadSkills()),
    expect: () => [
      SkillState.initial().copyWith(isLoading: true, error: null),
      SkillState.initial()
          .copyWith(isLoading: false, error: 'Error loading skills'),
    ],
    verify: (_) {
      verify(() => getAllSkillsUsecase.call()).called(1);
    },
  );
}
