import 'package:flutter/material.dart';
import 'package:projectsyeti/views/login_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes:{
        "/":(context)=>const LoginView(),
      }
    );
  }
}