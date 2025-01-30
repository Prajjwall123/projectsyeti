import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:projectsyeti/core/network/api_service.dart';
import 'package:projectsyeti/core/network/hive_service.dart';
import 'package:projectsyeti/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:projectsyeti/features/auth/data/repository/local_repository/auth_local_repository.dart';
import 'package:projectsyeti/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:projectsyeti/features/auth/domain/use_case/login_usecase.dart';
import 'package:projectsyeti/features/auth/domain/use_case/register_usecase.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:projectsyeti/features/home/presentation/view_model/home_cubit.dart';

import '../../features/auth/data/data_source/local_data_source/auth_local_data_source.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initHiveService();
  _initApiService();
  _initAuthDependencies();
  _initLoginDependencies();
  _initHomeDependencies();
}

void _initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

void _initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

void _initAuthDependencies() {
  // getIt.registerLazySingleton<AuthLocalDataSource>(
  //     () => AuthLocalDataSource(getIt<HiveService>()));

  // getIt.registerLazySingleton<AuthLocalRepository>(
  //     () => AuthLocalRepository(getIt<AuthLocalDataSource>()));

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
      () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()));

  getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(getIt<AuthRemoteRepository>()));
  getIt.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(getIt<AuthRemoteRepository>()));

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
    ),
  );
}

void _initLoginDependencies() {
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

void _initHomeDependencies() {
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
}
