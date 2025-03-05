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
  late MockGetAllSkillsUsecase mockGetAllSkillsUsecase;
  late MockGetSkillByIdUsecase mockGetSkillByIdUsecase;

  const tSkill = SkillEntity(skillId: '1', name: 'Test Skill');
  const tSkill2 = SkillEntity(skillId: '2', name: 'Test Skill 2');
  final tSkills = [tSkill, tSkill2];
  const tFailure = ApiFailure(message: 'Something went wrong');

  setUpAll(() {
    registerFallbackValue(const GetSkillByIdParams(skillId: 'fake'));
  });

  setUp(() {
    mockGetAllSkillsUsecase = MockGetAllSkillsUsecase();
    mockGetSkillByIdUsecase = MockGetSkillByIdUsecase();
  });

  group('SkillBloc with initial LoadSkills', () {
    blocTest<SkillBloc, SkillState>(
      'emits [loading, success] when initial LoadSkills succeeds',
      build: () {
        when(() => mockGetAllSkillsUsecase.call())
            .thenAnswer((_) async => Right(tSkills));
        return SkillBloc(
          getAllSkillsUsecase: mockGetAllSkillsUsecase,
          getSkillByIdUsecase: mockGetSkillByIdUsecase,
        );
      },
      expect: () => [
        SkillState.initial().copyWith(isLoading: true),
        SkillState.initial().copyWith(skills: tSkills, isLoading: false),
      ],
      verify: (_) {
        verify(() => mockGetAllSkillsUsecase.call()).called(1);
      },
    );

    blocTest<SkillBloc, SkillState>(
      'emits loading, error when initial LoadSkills fails',
      build: () {
        when(() => mockGetAllSkillsUsecase.call())
            .thenAnswer((_) async => const Left(tFailure));
        return SkillBloc(
          getAllSkillsUsecase: mockGetAllSkillsUsecase,
          getSkillByIdUsecase: mockGetSkillByIdUsecase,
        );
      },
      expect: () => [
        SkillState.initial().copyWith(isLoading: true),
        SkillState.initial()
            .copyWith(isLoading: false, error: tFailure.message),
      ],
      verify: (_) {
        verify(() => mockGetAllSkillsUsecase.call()).called(1);
      },
    );

    blocTest<SkillBloc, SkillState>(
      'handles GetSkillById after successful initial load',
      build: () {
        when(() => mockGetAllSkillsUsecase.call())
            .thenAnswer((_) async => Right(tSkills));
        when(() => mockGetSkillByIdUsecase.call(any()))
            .thenAnswer((_) async => const Right(tSkill));
        return SkillBloc(
          getAllSkillsUsecase: mockGetAllSkillsUsecase,
          getSkillByIdUsecase: mockGetSkillByIdUsecase,
        );
      },
      act: (bloc) => bloc.add(const GetSkillByIdEvent('1')),
      expect: () => [
        SkillState.initial().copyWith(isLoading: true),
        SkillState.initial().copyWith(skills: tSkills, isLoading: false),
        SkillState.initial().copyWith(skills: tSkills, isLoading: true),
        SkillState.initial().copyWith(
          skills: tSkills,
          selectedSkill: tSkill,
          isLoading: false,
        ),
      ],
      verify: (_) {
        verify(() => mockGetAllSkillsUsecase.call()).called(1);
        verify(() => mockGetSkillByIdUsecase
            .call(const GetSkillByIdParams(skillId: '1'))).called(1);
      },
    );

    blocTest<SkillBloc, SkillState>(
      'handles GetSkillById failure after successful initial load',
      build: () {
        when(() => mockGetAllSkillsUsecase.call())
            .thenAnswer((_) async => Right(tSkills));
        when(() => mockGetSkillByIdUsecase.call(any()))
            .thenAnswer((_) async => const Left(tFailure));
        return SkillBloc(
          getAllSkillsUsecase: mockGetAllSkillsUsecase,
          getSkillByIdUsecase: mockGetSkillByIdUsecase,
        );
      },
      act: (bloc) => bloc.add(const GetSkillByIdEvent('1')),
      expect: () => [
        SkillState.initial().copyWith(isLoading: true),
        SkillState.initial().copyWith(skills: tSkills, isLoading: false),
        SkillState.initial().copyWith(skills: tSkills, isLoading: true),
        SkillState.initial().copyWith(
          skills: tSkills,
          isLoading: false,
          error: tFailure.message,
        ),
      ],
      verify: (_) {
        verify(() => mockGetAllSkillsUsecase.call()).called(1);
        verify(() => mockGetSkillByIdUsecase
            .call(const GetSkillByIdParams(skillId: '1'))).called(1);
      },
    );
  });
}
