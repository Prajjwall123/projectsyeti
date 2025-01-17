import 'package:flutter/material.dart';
import 'package:projectsyeti/core/app_theme/app_theme.dart';
import 'package:projectsyeti/features/home/presentation/view/dashboard_view.dart';
import 'package:projectsyeti/features/home/presentation/view/login_view.dart';
import 'package:projectsyeti/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:projectsyeti/features/home/presentation/view/register_view.dart';
import 'package:projectsyeti/features/splash/presentation/view/splash_screen_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        routes: {
          "/": (context) => const SplashScreen(),
          "/login": (context) => const LoginView(),
          "/onboarding": (context) => const OnboardingView(),
          "/register": (context) => const RegisterView(),
          "/dashboard": (context) => const DashboardView(),
        });
  }
}
