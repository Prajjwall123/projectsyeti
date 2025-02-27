import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectsyeti/app/di/di.dart';
import 'package:projectsyeti/app/app.dart';
import 'package:projectsyeti/features/auth/data/model/auth_hive_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(UserHiveModelAdapter());

  runApp(const MyApp());
}
