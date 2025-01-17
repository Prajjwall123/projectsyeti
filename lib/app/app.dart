import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/core/app_theme/app_theme.dart';
import 'package:projectsyeti/features/home/presentation/view/dashboard_view.dart';
import 'package:projectsyeti/features/auth/presentation/view/login_view.dart';
import 'package:projectsyeti/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:projectsyeti/features/auth/presentation/view/register_view.dart';
import 'package:projectsyeti/features/splash/presentation/view/splash_screen_view.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:projectsyeti/features/home/presentation/view_model/home_cubit.dart';
import 'package:projectsyeti/app/di/di.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (_) => getIt<RegisterBloc>(),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => getIt<HomeCubit>(),
        ),
      ],
      child: MaterialApp(
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        routes: {
          "/": (context) => const SplashScreen(),
          "/login": (context) => LoginView(),
          "/onboarding": (context) => const OnboardingView(),
          "/register": (context) => const RegisterView(),
          "/dashboard": (context) => const DashboardView(),
        },
      ),
    );
  }
}
