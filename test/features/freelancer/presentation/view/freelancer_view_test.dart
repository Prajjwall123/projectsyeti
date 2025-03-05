import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectsyeti/core/app_theme/theme_provider.dart';
import 'package:projectsyeti/features/freelancer/presentation/view/freelancer_view.dart';
import 'package:projectsyeti/features/freelancer/presentation/view_model/freelancer_bloc.dart';
import 'package:provider/provider.dart';

import '../test_data/freelancer_test_data.dart';

class MockFreelancerBloc extends MockBloc<FreelancerEvent, FreelancerState>
    implements FreelancerBloc {
  @override
  bool get isClosed => false;
}

class MockThemeProvider extends Mock implements ThemeProvider {}

void main() {
  late MockFreelancerBloc freelancerBloc;
  late MockThemeProvider themeProvider;

  setUp(() {
    freelancerBloc = MockFreelancerBloc();
    themeProvider = MockThemeProvider();

    when(() => themeProvider.themeMode).thenReturn(ThemeMode.light);
  });

  Widget loadFreelancerView(
      {String freelancerId = '679e5d8f4e658cfacb72a07d'}) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
          BlocProvider<FreelancerBloc>.value(value: freelancerBloc),
        ],
        child: FreelancerView(freelancerId: freelancerId),
      ),
    );
  }

  testWidgets("check for the text in the Freelancer UI", (tester) async {
    when(() => freelancerBloc.state).thenReturn(FreelancerLoaded(freelancer));
    await tester.pumpWidget(loadFreelancerView());
    await tester.pumpAndSettle();

    expect(find.text('Freelancer Profile'), findsOneWidget);
    expect(find.text('Prajwal Pokhrel'), findsOneWidget);
    expect(find.text('Profession: software developer'), findsOneWidget);
    expect(find.text('Location: kathmandu'), findsOneWidget);
    expect(find.text('Experience: 5 years'), findsOneWidget);
    expect(
        find.widgetWithText(ElevatedButton, 'Update Profile'), findsOneWidget);
    expect(find.text('About Me'), findsOneWidget);
    expect(find.text('I work at'), findsOneWidget);
    expect(find.text('freelancer'), findsOneWidget);
    expect(find.text('Languages'), findsOneWidget);
    expect(find.text('nepali, english, hindi'), findsOneWidget);
    expect(find.text('Availability'), findsOneWidget);
    expect(find.text('part time'), findsOneWidget);
    expect(find.text('Bio'), findsOneWidget);
    expect(find.text('I like to go swimming'), findsOneWidget);
    expect(find.text('Experience'), findsOneWidget);
    expect(find.text('web developer'), findsOneWidget);
    expect(
        find.text('I did some work in Web API development.'), findsOneWidget);
    expect(find.text('at technergy global | 2025 - 2025'), findsOneWidget);
    expect(find.text('Mobile App Developer'), findsOneWidget);
    expect(
        find.text('I did some flutter mobile app development'), findsOneWidget);
    expect(
        find.text('at Stable Cluster Pvt. Ltd. | 2024 - 2025'), findsOneWidget);
    expect(find.text('Skills'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('React'), findsOneWidget);
    expect(find.text('Certifications'), findsOneWidget);
    expect(find.text('CCNP - CISCO'), findsOneWidget);
    expect(find.text('Certification 2 - My startup'), findsOneWidget);

    verify(() => freelancerBloc.add(
        const GetFreelancerByIdEvent('679e5d8f4e658cfacb72a07d'))).called(1);
  });

  testWidgets("check for error state", (tester) async {
    when(() => freelancerBloc.state)
        .thenReturn(const FreelancerError('Failed to load freelancer'));
    await tester.pumpWidget(loadFreelancerView());
    await tester.pumpAndSettle();

    expect(find.text('Failed to load freelancer'), findsOneWidget);
  });

  testWidgets("check for no freelancer data", (tester) async {
    when(() => freelancerBloc.state).thenReturn(FreelancerInitial());
    await tester.pumpWidget(loadFreelancerView());
    await tester.pumpAndSettle();

    expect(find.text('No Freelancer Data Available'), findsOneWidget);
  });

  testWidgets("check for freelancer loaded successfully", (tester) async {
    when(() => freelancerBloc.state).thenReturn(FreelancerLoaded(freelancer));
    await tester.pumpWidget(loadFreelancerView());
    await tester.pumpAndSettle();

    expect(freelancerBloc.state, FreelancerLoaded(freelancer));
    expect(find.text('Prajwal Pokhrel'), findsOneWidget);
  });
}
