import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectsyeti/core/error/failure.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/project/domain/use_case/get_all_projects_usecase.dart';
import 'package:projectsyeti/features/project/domain/use_case/get_project_by_id_usecase.dart';
import 'package:projectsyeti/features/project/domain/use_case/get_projects_by_freelancer_usecase.dart';
import 'package:projectsyeti/features/project/domain/use_case/update_project_by_id_usecase.dart';
import 'package:projectsyeti/features/project/presentation/view_model/bloc/project_bloc.dart';

class MockGetAllProjectsUsecase extends Mock implements GetAllProjectsUsecase {}

class MockGetProjectByIdUsecase extends Mock implements GetProjectByIdUsecase {}

class MockGetProjectsByFreelancerIdUsecase extends Mock
    implements GetProjectsByFreelancerIdUsecase {}

class MockUpdateProjectByIdUsecase extends Mock
    implements UpdateProjectByIdUsecase {}

void main() {
  late MockGetAllProjectsUsecase mockGetAllProjectsUsecase;
  late MockGetProjectByIdUsecase mockGetProjectByIdUsecase;
  late MockGetProjectsByFreelancerIdUsecase
      mockGetProjectsByFreelancerIdUsecase;
  late MockUpdateProjectByIdUsecase mockUpdateProjectByIdUsecase;

  // Test data
  final DateTime testDate = DateTime(2025, 12, 31);
  final tProject = ProjectEntity(
    projectId: '1',
    companyId: 'c1',
    companyName: 'Test Company',
    companyLogo: 'logo.png',
    headquarters: 'Test HQ',
    title: 'Test Project',
    category: const ['cat1', 'cat2'],
    requirements: 'Test Requirements',
    description: 'Test Description',
    duration: '3 months',
    postedDate: testDate,
    status: 'active',
    bidCount: 5,
    awardedTo: 'f1',
    feedbackRequestedMessage: 'Please provide feedback',
    link: 'http://example.com',
    feedbackRespondMessage: 'Thanks for the feedback',
  );
  final tProject2 = ProjectEntity(
    projectId: '2',
    companyId: 'c2',
    companyName: 'Test Company 2',
    companyLogo: 'logo2.png',
    headquarters: 'Test HQ 2',
    title: 'Test Project 2',
    category: const ['cat3', 'cat4'],
    requirements: 'Test Requirements 2',
    description: 'Test Description 2',
    duration: '6 months',
    postedDate: testDate,
    status: 'active',
    bidCount: 3,
    awardedTo: 'f2',
    feedbackRequestedMessage: 'Please provide feedback 2',
    link: 'http://example2.com',
    feedbackRespondMessage: 'Thanks for the feedback 2',
  );
  final tProjects = [tProject, tProject2];
  const tFailure = ApiFailure(message: 'Something went wrong');

  // Register fallbacks
  setUpAll(() {
    registerFallbackValue(const GetProjectByIdParams(projectId: 'fake'));
    registerFallbackValue(
        const GetProjectsByFreelancerIdParams(freelancerId: 'fake'));
    registerFallbackValue(
        UpdateProjectByIdParams(projectId: 'fake', updatedProject: tProject));
    registerFallbackValue(const NoParams());
  });

  setUp(() {
    mockGetAllProjectsUsecase = MockGetAllProjectsUsecase();
    mockGetProjectByIdUsecase = MockGetProjectByIdUsecase();
    mockGetProjectsByFreelancerIdUsecase =
        MockGetProjectsByFreelancerIdUsecase();
    mockUpdateProjectByIdUsecase = MockUpdateProjectByIdUsecase();
  });

  group('ProjectBloc', () {
    blocTest<ProjectBloc, ProjectState>(
      'emits [loading, success] when GetAllProjects succeeds',
      build: () {
        when(() => mockGetAllProjectsUsecase(any()))
            .thenAnswer((_) async => Right(tProjects));
        return ProjectBloc(
          getAllProjectsUsecase: mockGetAllProjectsUsecase,
          getProjectByIdUsecase: mockGetProjectByIdUsecase,
          getProjectByFreelancerIdUsecase: mockGetProjectsByFreelancerIdUsecase,
          updateProjectByIdUsecase: mockUpdateProjectByIdUsecase,
        );
      },
      act: (bloc) => bloc.add(GetAllProjectsEvent()),
      expect: () => [
        ProjectLoading(),
        ProjectsLoaded(tProjects),
      ],
      verify: (_) {
        verify(() => mockGetAllProjectsUsecase(const NoParams())).called(1);
      },
    );

    blocTest<ProjectBloc, ProjectState>(
      'emits [loading, error] when GetAllProjects fails',
      build: () {
        when(() => mockGetAllProjectsUsecase(any()))
            .thenAnswer((_) async => const Left(tFailure));
        return ProjectBloc(
          getAllProjectsUsecase: mockGetAllProjectsUsecase,
          getProjectByIdUsecase: mockGetProjectByIdUsecase,
          getProjectByFreelancerIdUsecase: mockGetProjectsByFreelancerIdUsecase,
          updateProjectByIdUsecase: mockUpdateProjectByIdUsecase,
        );
      },
      act: (bloc) => bloc.add(GetAllProjectsEvent()),
      expect: () => [
        ProjectLoading(),
        const ProjectError('Something went wrong'),
      ],
      verify: (_) {
        verify(() => mockGetAllProjectsUsecase(const NoParams())).called(1);
      },
    );

    blocTest<ProjectBloc, ProjectState>(
      'emits [loading, success] when GetProjectsByFreelancerId succeeds',
      build: () {
        when(() => mockGetProjectsByFreelancerIdUsecase(any()))
            .thenAnswer((_) async => Right(tProjects));
        return ProjectBloc(
          getAllProjectsUsecase: mockGetAllProjectsUsecase,
          getProjectByIdUsecase: mockGetProjectByIdUsecase,
          getProjectByFreelancerIdUsecase: mockGetProjectsByFreelancerIdUsecase,
          updateProjectByIdUsecase: mockUpdateProjectByIdUsecase,
        );
      },
      act: (bloc) => bloc.add(const GetProjectsByFreelancerIdEvent('f1')),
      expect: () => [
        ProjectLoading(),
        ProjectsLoaded(tProjects),
      ],
      verify: (_) {
        verify(() => mockGetProjectsByFreelancerIdUsecase(
              const GetProjectsByFreelancerIdParams(freelancerId: 'f1'),
            )).called(1);
      },
    );

    blocTest<ProjectBloc, ProjectState>(
      'emits [loading, success] when GetProjectById succeeds',
      build: () {
        when(() => mockGetProjectByIdUsecase(any()))
            .thenAnswer((_) async => Right(tProject));
        return ProjectBloc(
          getAllProjectsUsecase: mockGetAllProjectsUsecase,
          getProjectByIdUsecase: mockGetProjectByIdUsecase,
          getProjectByFreelancerIdUsecase: mockGetProjectsByFreelancerIdUsecase,
          updateProjectByIdUsecase: mockUpdateProjectByIdUsecase,
        );
      },
      act: (bloc) => bloc.add(const GetProjectByIdEvent('1')),
      expect: () => [
        ProjectLoading(),
        ProjectLoaded(tProject),
      ],
      verify: (_) {
        verify(() => mockGetProjectByIdUsecase(
              const GetProjectByIdParams(projectId: '1'),
            )).called(1);
      },
    );
  });
}
