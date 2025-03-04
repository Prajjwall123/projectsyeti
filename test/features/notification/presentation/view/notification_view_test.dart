import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projectsyeti/features/notification/domain/entity/notification_entity.dart';
import 'package:projectsyeti/features/notification/presentation/view/notification_view.dart';
import 'package:projectsyeti/features/notification/presentation/view_model/notification_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockNotificationBloc
    extends MockBloc<NotificationEvent, NotificationState>
    implements NotificationBloc {}

class MockBuildContext extends Mock implements BuildContext {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockNotificationBloc notificationBloc;
  late MockBuildContext mockContext;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    notificationBloc = MockNotificationBloc();
    mockContext = MockBuildContext();
    mockSharedPreferences = MockSharedPreferences();

    when(() => notificationBloc.state).thenReturn(NotificationInitial());

    registerFallbackValue(const GetNotificationByFreelancerIdEvent('test'));
    registerFallbackValue(const SeenNotificationEvent('test'));
    registerFallbackValue(mockContext);

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

  final DateTime testDate = DateTime(2025, 3, 3);
  final notification1 = NotificationEntity(
    notificationId: 'notification1',
    recipient: 'freelancerTest',
    recipientType: 'freelancer',
    message:
        "Feedback received on project: 'AI-Powered Resume Screening System!'",
    isRead: false,
    createdAt: testDate,
  );
  final notification2 = NotificationEntity(
    notificationId: 'notification2',
    recipient: 'freelancerTest',
    recipientType: 'freelancer',
    message:
        "Feedback received on project: 'AI-Powered Resume Screening System!'",
    isRead: true,
    createdAt: testDate,
  );
  final notifications = [notification1, notification2];

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
}
