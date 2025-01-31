import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:projectsyeti/app/shared_prefs/token_shared_prefs.dart';
import 'package:projectsyeti/core/network/api_service.dart';
import 'package:projectsyeti/core/network/hive_service.dart';
import 'package:projectsyeti/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:projectsyeti/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:projectsyeti/features/auth/domain/repository/auth_repository.dart';
import 'package:projectsyeti/features/auth/domain/use_case/login_usecase.dart';
import 'package:projectsyeti/features/auth/domain/use_case/register_usecase.dart';
import 'package:projectsyeti/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/bloc/register_bloc.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:projectsyeti/features/home/presentation/view_model/home_cubit.dart';
import 'package:projectsyeti/features/skill/data/data_source/remote_data_source/skill_remote_data_source.dart';
import 'package:projectsyeti/features/skill/data/repository/skill_remote_repository.dart';
import 'package:projectsyeti/features/skill/domain/repository/skill_repository.dart';
import 'package:projectsyeti/features/skill/domain/use_case/get_all_skills_usecase.dart';
import 'package:projectsyeti/features/skill/presentation/view_model/bloc/skill_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initHiveService();
  _initApiService();
  _initSharedPreferences();
  _initAuthDependencies();
  _initLoginDependencies();
  _initHomeDependencies();
  _initSkillDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
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
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
      uploadImageUsecase: getIt<UploadImageUsecase>(),
      skillBloc: getIt<SkillBloc>(),
    ),
  );
}

void _initLoginDependencies() {
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<LoginUseCase>(
    () =>
        LoginUseCase(getIt<AuthRemoteRepository>(), getIt<TokenSharedPrefs>()),
  );
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

void _initSkillDependencies() {
  // Register GetAllSkillsUsecase with the SkillRepository dependency
  getIt.registerLazySingleton<GetAllSkillsUsecase>(
    () => GetAllSkillsUsecase(skillRepository: getIt<SkillRemoteRepository>()),
  );

  getIt.registerLazySingleton<SkillRemoteRepository>(
    () => SkillRemoteRepository(
      getIt<SkillRemoteDataSource>(),
    ),
  );

  getIt.registerFactory<SkillRemoteDataSource>(
      () => SkillRemoteDataSource(getIt<Dio>()));

  // Register SkillBloc
  getIt.registerFactory<SkillBloc>(
    () => SkillBloc(getAllSkillsUsecase: getIt<GetAllSkillsUsecase>()),
  );
}
