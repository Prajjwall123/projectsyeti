import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectsyeti/app/di/di.dart';
import 'package:projectsyeti/app/app.dart';
import 'package:projectsyeti/features/auth/data/model/auth_hive_model.dart';
import 'package:projectsyeti/features/project/data/model/project_hive_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  try {
    Hive.registerAdapter(UserHiveModelAdapter());
    debugPrint("UserHiveModelAdapter registered successfully");
  } catch (e) {
    debugPrint("Error registering UserHiveModelAdapter: $e");
  }
  try {
    Hive.registerAdapter(ProjectHiveModelAdapter());
    debugPrint("ProjectHiveModelAdapter registered successfully");
  } catch (e) {
    debugPrint("Error registering ProjectHiveModelAdapter: $e");
  }

  await initDependencies();

  runApp(const MyApp());
}
