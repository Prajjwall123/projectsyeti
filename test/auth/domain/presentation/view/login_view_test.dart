import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectsyeti/features/auth/presentation/view/login_view.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/login/login_bloc.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  late MockLoginBloc loginBloc;

  setUp(() {
    loginBloc = MockLoginBloc();
  });

  Widget loadLoginView() {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: MaterialApp(
        home: LoginView(),
      ),
    );
  }

  testWidgets("Check if Login and Register buttons are present",
      (tester) async {
    await tester.pumpWidget(loadLoginView()); // Load LoginView
    await tester.pumpAndSettle(); // Wait for animations and rendering

    debugPrint(tester.allWidgets.toString()); // Debug: Print all widgets

    // Find buttons by text
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });

  testWidgets("Check if username and password fields work", (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key('emailField')), "test@gmail.com");
    await tester.enterText(
        find.byKey(const Key('passwordField')), "password123");

    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('test@gmail.com'), findsOneWidget);
    expect(find.text('password123'), findsOneWidget);
  });

  testWidgets("Check validation errors for empty fields", (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Login')); // Tap the button
    await tester.pump(); // Allow Snackbar animation to start

    // Look for the Snackbar widget
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Please fill all fields'), findsOneWidget);
  });

  testWidgets("Check successful login event", (tester) async {
    when(() => loginBloc.state)
        .thenReturn(LoginState(isLoading: false, isSuccess: true));

    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(TextFormField).at(0), "test@example.com");
    await tester.enterText(find.byType(TextFormField).at(1), "password123");

    await tester.tap(find.widgetWithText(ElevatedButton, "Login"));
    await tester.pumpAndSettle();

    expect(loginBloc.state.isSuccess, true);
  });
}
