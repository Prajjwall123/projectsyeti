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
import 'package:projectsyeti/features/auth/domain/use_case/verify_otp_usecase.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/bloc/register_bloc.dart';
import 'package:projectsyeti/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:projectsyeti/features/bidding/data/data_source/remote_data_source/bidding_remote_data_source.dart';
import 'package:projectsyeti/features/bidding/data/repository/remote_repository/bidding_remote_repository.dart';
import 'package:projectsyeti/features/bidding/domain/repository/bidding_repository.dart';
import 'package:projectsyeti/features/bidding/domain/usecase/create_bid_usecase.dart';
import 'package:projectsyeti/features/bidding/presentation/viewmodel/bidding_bloc.dart';
import 'package:projectsyeti/features/company/data/data_source/remote_data_source/company_remote_data_source.dart';
import 'package:projectsyeti/features/company/data/repository/remote_repository/company_remote_repository.dart';
import 'package:projectsyeti/features/company/domain/entity/repository/company_repository.dart';
import 'package:projectsyeti/features/company/domain/use_case/get_company_by_id_usecase.dart';
import 'package:projectsyeti/features/freelancer/data/data_source/remote_data_source/freelancer_remote_data_source.dart';
import 'package:projectsyeti/features/freelancer/data/repository/remote_repository/freelancer_remote_repository.dart';
import 'package:projectsyeti/features/freelancer/domain/repository/freelancer_repository.dart';
import 'package:projectsyeti/features/freelancer/domain/usecase/get_freelancer_by_id_usecase.dart';
import 'package:projectsyeti/features/freelancer/domain/usecase/update_freelancer_by_id_usecase.dart';
import 'package:projectsyeti/features/freelancer/presentation/view_model/freelancer_bloc.dart';
import 'package:projectsyeti/features/home/presentation/view_model/home_cubit.dart';
import 'package:projectsyeti/features/notification/data/data_source/remote_data_source/notification_remote_data_source.dart';
import 'package:projectsyeti/features/notification/data/repository/remote_repository/notification_remote_repository.dart';
import 'package:projectsyeti/features/notification/domain/repository/notification_repository.dart';
import 'package:projectsyeti/features/notification/domain/usecase/get_notification_by_freelancer_id_usecase.dart';
import 'package:projectsyeti/features/notification/domain/usecase/seen_notification_by_freelancer_id_usecase.dart';
import 'package:projectsyeti/features/notification/presentation/view_model/notification_bloc.dart';
import 'package:projectsyeti/features/project/data/data_source/remote_data_source/project_remote_data_source.dart';
import 'package:projectsyeti/features/project/data/repository/remote_repository/project_remote_repository.dart';
import 'package:projectsyeti/features/project/domain/repository/project_repository.dart';
import 'package:projectsyeti/features/project/domain/use_case/get_all_projects_usecase.dart';
import 'package:projectsyeti/features/project/domain/use_case/get_project_by_id_usecase.dart';
import 'package:projectsyeti/features/project/domain/use_case/get_projects_by_freelancer_usecase.dart';
import 'package:projectsyeti/features/project/presentation/view_model/bloc/project_bloc.dart';
import 'package:projectsyeti/features/skill/data/data_source/remote_data_source/skill_remote_data_source.dart';
import 'package:projectsyeti/features/skill/data/repository/skill_remote_repository.dart';
import 'package:projectsyeti/features/skill/domain/repository/skill_repository.dart';
import 'package:projectsyeti/features/skill/domain/use_case/get_all_skills_usecase.dart';
import 'package:projectsyeti/features/skill/domain/use_case/get_skill_by_id_usecase.dart';
import 'package:projectsyeti/features/skill/presentation/view_model/bloc/skill_bloc.dart';
import 'package:projectsyeti/features/company/presentation/view_model/bloc/company_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initHiveService();
  _initApiService();
  await _initSharedPreferences();
  _initSkillDependencies();
  _initAuthDependencies();
  _initLoginDependencies();
  _initHomeDependencies();
  _initCompanyDependencies();
  _initProjectDependencies();
  _initFreelancerDependencies();
  _initBiddingDependencies();
  _initNotificationDependencies();
}

void _initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

void _initApiService() {
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

void _initSkillDependencies() {
  getIt.registerLazySingleton<SkillRemoteDataSource>(
    () => SkillRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ISkillRepository>(
    () => SkillRemoteRepository(getIt<SkillRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetAllSkillsUsecase>(
    () => GetAllSkillsUsecase(skillRepository: getIt<ISkillRepository>()),
  );

  getIt.registerLazySingleton<GetSkillByIdUsecase>(
    () => GetSkillByIdUsecase(skillRepository: getIt<ISkillRepository>()),
  );

  getIt.registerFactory<SkillBloc>(
    () => SkillBloc(
      getAllSkillsUsecase: getIt<GetAllSkillsUsecase>(),
      getSkillByIdUsecase: getIt<GetSkillByIdUsecase>(),
    ),
  );
}

void _initAuthDependencies() {
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>(), getIt<TokenSharedPrefs>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<VerifyOtpUsecase>(
    () => VerifyOtpUsecase(authRepository: getIt<AuthRemoteRepository>()),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
      uploadImageUsecase: getIt<UploadImageUsecase>(),
      verifyOtpUsecase: getIt<VerifyOtpUsecase>(),
      skillBloc: getIt<SkillBloc>(),
    ),
  );
}

void _initLoginDependencies() {
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
  getIt.registerLazySingleton<HomeCubit>(
    () => HomeCubit(
      getIt<GetAllProjectsUsecase>(),
      getIt<GetAllSkillsUsecase>(),
      getIt<GetFreelancerByIdUsecase>(),
      getIt<TokenSharedPrefs>(),
    ),
  );
}

void _initCompanyDependencies() {
  getIt.registerLazySingleton<CompanyRemoteDataSource>(
    () => CompanyRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ICompanyRepository>(
    () => CompanyRemoteRepository(getIt<CompanyRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetCompanyByIdUseCase>(
    () => GetCompanyByIdUseCase(getIt<ICompanyRepository>()),
  );

  getIt.registerFactory<CompanyBloc>(
    () => CompanyBloc(getIt<GetCompanyByIdUseCase>()),
  );
}

void _initProjectDependencies() {
  getIt.registerLazySingleton<ProjectRemoteDataSource>(
    () => ProjectRemoteDataSource(
        dio: getIt<Dio>(), skillRepository: getIt<ISkillRepository>()),
  );

  getIt.registerLazySingleton<IProjectRepository>(
    () => ProjectRemoteRepository(getIt<ProjectRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetAllProjectsUsecase>(
    () => GetAllProjectsUsecase(projectRepository: getIt<IProjectRepository>()),
  );

  getIt.registerLazySingleton<GetProjectByIdUsecase>(
    () => GetProjectByIdUsecase(projectRepository: getIt<IProjectRepository>()),
  );

  getIt.registerLazySingleton<GetProjectsByFreelancerIdUsecase>(
    () => GetProjectsByFreelancerIdUsecase(
        projectRepository: getIt<IProjectRepository>()),
  );

  getIt.registerFactory<ProjectBloc>(
    () => ProjectBloc(
      getAllProjectsUsecase: getIt<GetAllProjectsUsecase>(),
      getProjectByIdUsecase: getIt<GetProjectByIdUsecase>(),
      getProjectByFreelancerIdUsecase:
          getIt<GetProjectsByFreelancerIdUsecase>(),
    ),
  );
}

void _initFreelancerDependencies() {
  getIt.registerLazySingleton<FreelancerRemoteDataSource>(
    () => FreelancerRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<IFreelancerRepository>(
    () => FreelancerRemoteRepository(getIt<FreelancerRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetFreelancerByIdUsecase>(
    () => GetFreelancerByIdUsecase(
        freelancerRepository: getIt<IFreelancerRepository>()),
  );

  getIt.registerLazySingleton<UpdateFreelancerByIdUsecase>(
    () => UpdateFreelancerByIdUsecase(
        freelancerRepository: getIt<IFreelancerRepository>()),
  );

  getIt.registerFactory<FreelancerBloc>(
    () => FreelancerBloc(
      getFreelancerByIdUsecase: getIt<GetFreelancerByIdUsecase>(),
      updateFreelancerByIdUsecase: getIt<UpdateFreelancerByIdUsecase>(),
      uploadImageUsecase: getIt<UploadImageUsecase>(),
    ),
  );
}

void _initBiddingDependencies() {
  getIt.registerLazySingleton<BiddingRemoteDataSource>(
    () => BiddingRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<IBiddingRepository>(
    () => BiddingRemoteRepository(getIt<BiddingRemoteDataSource>()),
  );

  getIt.registerLazySingleton<CreateBidUseCase>(
    () => CreateBidUseCase(getIt<IBiddingRepository>()),
  );

  getIt.registerFactory<BiddingBloc>(
    () => BiddingBloc(createBidUsecase: getIt<CreateBidUseCase>()),
  );
}

void _initNotificationDependencies() {
  getIt.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<INotificationRepository>(
    () => NotificationRemoteRepository(getIt<NotificationRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetNotificationByFreelancerIdUsecase>(
    () => GetNotificationByFreelancerIdUsecase(
      notificationRepository: getIt<INotificationRepository>(),
    ),
  );

  getIt.registerLazySingleton<SeenNotificationByFreelancerIdUsecase>(
    () => SeenNotificationByFreelancerIdUsecase(
      notificationRepository: getIt<INotificationRepository>(),
    ),
  );

  getIt.registerFactory<NotificationBloc>(
    () => NotificationBloc(
      getNotificationsUsecase: getIt<GetNotificationByFreelancerIdUsecase>(),
      seenNotificationUsecase: getIt<SeenNotificationByFreelancerIdUsecase>(),
    ),
  );
}
