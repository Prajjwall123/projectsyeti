import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectsyeti/features/notification/presentation/view/notification_view.dart';
import 'package:projectsyeti/features/notification/presentation/view_model/notification_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test_data/notification_test_data.dart';

class MockNotificationBloc
    extends MockBloc<NotificationEvent, NotificationState>
    implements NotificationBloc {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockNotificationBloc notificationBloc;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    notificationBloc = MockNotificationBloc();
    mockSharedPreferences = MockSharedPreferences();

    when(() => notificationBloc.state).thenReturn(NotificationInitial());

    when(() => mockSharedPreferences.getString('userId'))
        .thenReturn('freelancerTest');
  });

  Widget loadNotificationView({String freelancerId = 'freelancerTest'}) {
    return MaterialApp(
      home: BlocProvider<NotificationBloc>.value(
        value: notificationBloc,
        child: NotificationView(freelancerId: freelancerId),
      ),
    );
  }

  testWidgets("check for empty notifications", (tester) async {
    whenListen(
      notificationBloc,
      Stream.fromIterable([
        NotificationLoading(),
        const NotificationLoaded([]),
      ]),
      initialState: NotificationInitial(),
    );

    await tester.pumpWidget(loadNotificationView());
    await tester.pumpAndSettle();

    expect(find.text('No notifications found'), findsOneWidget);
  });

  testWidgets("check for no action on tapping read notification",
      (tester) async {
    whenListen(
      notificationBloc,
      Stream.fromIterable([
        NotificationLoading(),
        NotificationLoaded(notifications),
      ]),
      initialState: NotificationInitial(),
    );

    await tester.pumpWidget(loadNotificationView());
    await tester.pumpAndSettle();

    await tester.tap(find
        .text(
            "Feedback received on project: 'AI-Powered Resume Screening System!'")
        .at(1));
    await tester.pumpAndSettle();

    verifyNever(() => notificationBloc.add(const SeenNotificationEvent('n2')));
  });

  testWidgets("check for notifications loaded successfully", (tester) async {
    whenListen(
      notificationBloc,
      Stream.fromIterable([
        NotificationLoading(),
        NotificationLoaded(notifications),
      ]),
      initialState: NotificationInitial(),
    );

    await tester.pumpWidget(loadNotificationView());
    await tester.pumpAndSettle();

    expect(notificationBloc.state, NotificationLoaded(notifications));
    expect(
        find.text(
            "Feedback received on project: 'AI-Powered Resume Screening System!'"),
        findsNWidgets(2));
  });
}
