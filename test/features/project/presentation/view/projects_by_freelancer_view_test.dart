import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/project/presentation/view/projects_by_freelancer_view.dart';
import 'package:projectsyeti/features/project/presentation/view_model/bloc/project_bloc.dart';

class MockProjectBloc extends MockBloc<ProjectEvent, ProjectState>
    implements ProjectBloc {
  @override
  bool get isClosed => false;
}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockProjectBloc projectBloc;
  late MockBuildContext mockContext;

  setUp(() {
    projectBloc = MockProjectBloc();
    mockContext = MockBuildContext();

    when(() => projectBloc.state).thenReturn(ProjectInitial());

    registerFallbackValue(const GetProjectsByFreelancerIdEvent('fake'));
    registerFallbackValue(UpdateProjectByIdEvent(
        'fake',
        ProjectEntity(
          projectId: 'fake',
          companyId: 'fake',
          companyName: 'fake',
          companyLogo: '',
          title: 'fake',
          category: const [],
          requirements: '',
          description: '',
          duration: '',
          postedDate: DateTime(2025, 3, 1),
          status: '',
          bidCount: 0,
        )));
    registerFallbackValue(mockContext);
  });

  Widget loadProjectsByFreelancerView({String freelancerId = 'f1'}) {
    return MaterialApp(
      home: BlocProvider<ProjectBloc>.value(
        value: projectBloc,
        child: ProjectsByFreelancerView(freelancerId: freelancerId),
      ),
    );
  }

  final DateTime testDate = DateTime(2025, 3, 1);
  final project1 = ProjectEntity(
    projectId: 'p1',
    companyId: 'c1',
    companyName: 'Technergy Global',
    companyLogo: '',
    title: 'Mobile application for Sanima bank',
    category: const [],
    requirements: '',
    description: '',
    duration: '',
    postedDate: testDate,
    status: 'In Progress',
    bidCount: 0,
  );
  final project2 = ProjectEntity(
    projectId: 'p2',
    companyId: 'c2',
    companyName: 'Technergy Global',
    companyLogo: '',
    title: 'AI-Powered Resume Screening System',
    category: const [],
    requirements: '',
    description: '',
    duration: '',
    postedDate: testDate,
    status: 'Feedback Requested',
    bidCount: 0,
  );
  final projects = [project1, project2];

  testWidgets("check for show feedback with feedback", (tester) async {
    final projectWithFeedback = project2.copyWith(
      link: 'https://example.com',
      feedbackRespondMessage: 'Great work on the project!',
    );
    final updatedProjects = [project1, projectWithFeedback];

    whenListen(
      projectBloc,
      Stream.fromIterable([
        ProjectLoading(),
        ProjectsLoaded(updatedProjects),
      ]),
      initialState: ProjectInitial(),
    );

    await tester.pumpWidget(loadProjectsByFreelancerView());
    await tester.pumpAndSettle();

    expect(find.text('Show Feedback'), findsNWidgets(2));
    await tester.ensureVisible(find.text('Show Feedback').at(1));

    await tester.tap(find.text('Show Feedback').at(1));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Feedback for AI-Powered Resume Screening System"),
        findsOneWidget);
    expect(find.text('Progress Link: https://example.com'), findsOneWidget);
    expect(find.text('Message: Great work on the project!'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);

    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });
  testWidgets("check for show feedback with no feedback", (tester) async {
    whenListen(
      projectBloc,
      Stream.fromIterable([
        ProjectLoading(),
        ProjectsLoaded(projects),
      ]),
      initialState: ProjectInitial(),
    );

    await tester.pumpWidget(loadProjectsByFreelancerView());
    await tester.pumpAndSettle();

    expect(find.text('Show Feedback'), findsNWidgets(2));
    await tester.ensureVisible(find.text('Show Feedback').first);

    await tester.tap(find.text('Show Feedback').first);
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('No feedback response available for this project'),
        findsOneWidget);
  });

  testWidgets("check for view details", (tester) async {
    whenListen(
      projectBloc,
      Stream.fromIterable([
        ProjectLoading(),
        ProjectsLoaded(projects),
      ]),
      initialState: ProjectInitial(),
    );

    await tester.pumpWidget(loadProjectsByFreelancerView());
    await tester.pumpAndSettle();

    expect(find.text('View Details'), findsNWidgets(2));
    await tester.ensureVisible(find.text('View Details').first);

    await tester.tap(find.text('View Details').first);
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Viewing details for Mobile application for Sanima bank'),
        findsOneWidget);
  });
}
