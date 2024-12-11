import 'package:flutter/material.dart';
import 'package:projectsyeti/views/login_view.dart';
import 'package:projectsyeti/views/onboarding_view.dart';
import 'package:projectsyeti/views/register_view.dart';
import 'package:projectsyeti/views/splash_screen_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes:{
        "/":(context)=>const SplashScreen(),
        "/login":(context)=>const LoginView(),
        "/onboarding":(context)=> const OnboardingView(),
        "/register":(context)=> const RegisterView(),
      }
    );
  }
}