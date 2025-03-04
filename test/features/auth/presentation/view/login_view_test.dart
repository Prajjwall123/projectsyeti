import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/features/auth/presentation/view/login_view.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/login/login_bloc.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockLoginBloc loginBloc;
  late MockBuildContext mockContext;

  setUp(() {
    loginBloc = MockLoginBloc();
    mockContext = MockBuildContext();

    when(() => loginBloc.state)
        .thenReturn(LoginState(isLoading: false, isSuccess: false));

    registerFallbackValue(loginUserEvent(
      context: mockContext,
      email: 'test',
      password: 'test',
    ));
    registerFallbackValue(NavigateRegisterScreenEvent(
      context: mockContext,
      destination: Container(),
    ));
  });

  Widget loadLoginView() {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: MaterialApp(
        home: LoginView(),
      ),
    );
  }

  testWidgets("check for the text in the Login UI", (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    final loginButton = find.widgetWithText(ElevatedButton, 'Login');
    final registerButton = find.widgetWithText(ElevatedButton, 'Register');

    expect(loginButton, findsOneWidget);
    expect(registerButton, findsOneWidget);
  });

  testWidgets("check for the email and password with correct credentials",
      (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const ValueKey('username')));
    await tester.tap(find.byKey(const ValueKey('username')));
    await tester.enterText(
        find.byKey(const ValueKey('username')), "findmepokhrel@gmail.com");

    await tester.ensureVisible(find.byKey(const ValueKey('password')));
    await tester.tap(find.byKey(const ValueKey('password')));
    await tester.enterText(find.byKey(const ValueKey('password')), "password");

    await tester.pumpAndSettle();

    expect(find.text('findmepokhrel@gmail.com'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);
  });

  testWidgets("check for validator error", (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const ValueKey('signInButton')));
    await tester.tap(find.byKey(const ValueKey('signInButton')));

    await tester.pumpAndSettle();

    expect(find.text('Please enter username'), findsOneWidget);
    expect(find.text('Please enter password'), findsOneWidget);
    expect(find.text('Please fill all fields'), findsOneWidget);
  });
}
