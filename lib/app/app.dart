import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/app/di/di.dart';
import 'package:projectsyeti/core/app_theme/app_theme.dart';
import 'package:projectsyeti/features/auth/presentation/view/login_view.dart';
import 'package:projectsyeti/features/auth/presentation/view/register_view.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/bloc/register_bloc.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:projectsyeti/features/bidding/presentation/viewmodel/bidding_bloc.dart';
import 'package:projectsyeti/features/company/presentation/view_model/bloc/company_bloc.dart';
import 'package:projectsyeti/features/freelancer/presentation/view_model/freelancer_bloc.dart';
import 'package:projectsyeti/features/home/presentation/view/dashboard_view.dart';
import 'package:projectsyeti/features/home/presentation/view_model/home_cubit.dart';
import 'package:projectsyeti/features/notification/presentation/view_model/notification_bloc.dart';
import 'package:projectsyeti/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:projectsyeti/features/project/presentation/view/projects_by_freelancer_view.dart';
import 'package:projectsyeti/features/project/presentation/view_model/bloc/project_bloc.dart';
import 'package:projectsyeti/features/skill/presentation/view_model/bloc/skill_bloc.dart';
import 'package:projectsyeti/features/splash/presentation/view/splash_screen_view.dart';
import 'package:provider/provider.dart';
import 'package:projectsyeti/core/app_theme/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => getIt<LoginBloc>()),
        BlocProvider<RegisterBloc>(create: (_) => getIt<RegisterBloc>()),
        BlocProvider<HomeCubit>(create: (_) => getIt<HomeCubit>()),
        BlocProvider<SkillBloc>(create: (_) => getIt<SkillBloc>()),
        BlocProvider<CompanyBloc>(create: (_) => getIt<CompanyBloc>()),
        BlocProvider<ProjectBloc>(create: (_) => getIt<ProjectBloc>()),
        BlocProvider<FreelancerBloc>(create: (_) => getIt<FreelancerBloc>()),
        BlocProvider<BiddingBloc>(create: (_) => getIt<BiddingBloc>()),
        BlocProvider<NotificationBloc>(
            create: (_) => getIt<NotificationBloc>()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: Builder(builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            initialRoute: "/",
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(),
            darkTheme: getDarkTheme(),
            themeMode: themeProvider.themeMode,
            routes: {
              "/": (context) => const SplashScreen(),
              "/login": (context) => LoginView(),
              "/onboarding": (context) => const OnboardingView(),
              "/register": (context) => const RegisterView(),
              "/dashboard": (context) => const DashboardView(),
            },
          );
        }),
      ),
    );
  }
}
