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
  late GetAllProjectsUsecase mockGetAllProjectsUsecase;
  late GetProjectByIdUsecase mockGetProjectByIdUsecase;
  late GetProjectsByFreelancerIdUsecase mockGetProjectsByFreelancerIdUsecase;
  late UpdateProjectByIdUsecase mockUpdateProjectByIdUsecase;
  late ProjectBloc projectBloc;

  final DateTime testDate = DateTime(2025, 12, 31);
  final tProject = ProjectEntity(
    projectId: '67b381e3d7829584c1e3bb5',
    companyId: '679e52a2570ca2c950216916',
    companyName: 'Sanima bank',
    companyLogo: 'logo.png',
    title: 'Mobile application for Sanima bank',
    category: const ['679b4fe07deac15d47c7ce1', '67b6db3777717ee983c47339'],
    requirements: 'Implement JWT authentication',
    description:
        'Sanima bank, one of Nepals leading commercial banks is looking for a ...',
    duration: '12 months',
    postedDate: DateTime.parse('2025-02-22'),
    status: 'In Progress',
    bidCount: 0,
    awardedTo: '679e5d8f4e658cfacb72a07d',
    feedbackRequestedMessage: 'Please give me feedback for this',
    link: 'github.com',
    feedbackRespondMessage: 'Please add this new feature',
  );
  final tProject2 = ProjectEntity(
    projectId: '67c301e3e9a44af433df4de',
    companyId: '679e52a2570ca2c950216916',
    companyName: 'AI-Powered Resume Screening System',
    companyLogo: 'logo.png',
    title: 'AI-Powered Resume Screening System',
    category: const ['679b4fe07deac15d47c7ce1', '67b6db3777717ee983c47339'],
    requirements: 'Custom product filtering & search (...',
    description:
        'Looking for an AI system that can analyze resumes and shortlist candid...',
    duration: '8',
    postedDate: DateTime.parse('2025-03-01T12:47:31.952+00:00'),
    status: 'Feedback Requested',
    bidCount: 0,
    awardedTo: '679e5d8f4e658cfacb72a07d',
    feedbackRequestedMessage: 'Please give me some feedback',
    link: 'link',
    feedbackRespondMessage: 'it is good',
  );
  final tProjects = [tProject, tProject2];
  const tFailure = ApiFailure(message: 'Something went wrong');

  setUp(() {
    mockGetAllProjectsUsecase = MockGetAllProjectsUsecase();
    mockGetProjectByIdUsecase = MockGetProjectByIdUsecase();
    mockGetProjectsByFreelancerIdUsecase =
        MockGetProjectsByFreelancerIdUsecase();
    mockUpdateProjectByIdUsecase = MockUpdateProjectByIdUsecase();

    projectBloc = ProjectBloc(
      getAllProjectsUsecase: mockGetAllProjectsUsecase,
      getProjectByIdUsecase: mockGetProjectByIdUsecase,
      getProjectByFreelancerIdUsecase: mockGetProjectsByFreelancerIdUsecase,
      updateProjectByIdUsecase: mockUpdateProjectByIdUsecase,
    );

    registerFallbackValue(const GetProjectByIdParams(projectId: 'test'));
    registerFallbackValue(
        const GetProjectsByFreelancerIdParams(freelancerId: 'test'));
    registerFallbackValue(
        UpdateProjectByIdParams(projectId: 'test', updatedProject: tProject));
    registerFallbackValue(const NoParams());
  });

  blocTest<ProjectBloc, ProjectState>(
    'emits ProjectLoading, ProjectsLoaded when GetAllProjects succeeds',
    build: () {
      when(() => mockGetAllProjectsUsecase(any()))
          .thenAnswer((_) async => Right(tProjects));
      return projectBloc;
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
    'emits ProjectsLoaded when GetAllProjects succeeds with skip 1',
    build: () {
      when(() => mockGetAllProjectsUsecase(any()))
          .thenAnswer((_) async => Right(tProjects));
      return projectBloc;
    },
    act: (bloc) => bloc.add(GetAllProjectsEvent()),
    skip: 1,
    expect: () => [
      ProjectsLoaded(tProjects),
    ],
    verify: (_) {
      verify(() => mockGetAllProjectsUsecase(const NoParams())).called(1);
    },
  );

  blocTest<ProjectBloc, ProjectState>(
    'emits ProjectLoading, ProjectError when GetAllProjects fails',
    build: () {
      when(() => mockGetAllProjectsUsecase(any()))
          .thenAnswer((_) async => const Left(tFailure));
      return projectBloc;
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
    'emits ProjectLoading, ProjectsLoaded when GetProjectsByFreelancerId succeeds',
    build: () {
      when(() => mockGetProjectsByFreelancerIdUsecase(any()))
          .thenAnswer((_) async => Right(tProjects));
      return projectBloc;
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
    'emits ProjectLoading, ProjectLoaded when GetProjectById succeeds',
    build: () {
      when(() => mockGetProjectByIdUsecase(any()))
          .thenAnswer((_) async => Right(tProject));
      return projectBloc;
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
}
