import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/app/shared_prefs/token_shared_prefs.dart';
import 'package:projectsyeti/features/freelancer/domain/usecase/get_freelancer_by_id_usecase.dart';
import 'package:projectsyeti/features/project/domain/use_case/get_all_projects_usecase.dart';
import 'package:projectsyeti/features/skill/domain/use_case/get_all_skills_usecase.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:projectsyeti/features/wallet/domain/usecase/get_wallet_amount_usecased.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAllProjectsUsecase _getAllProjectsUsecase;
  final GetAllSkillsUsecase _getAllSkillsUsecase;
  final GetFreelancerByIdUsecase _getFreelancerByIdUsecase;
  final GetWalletAmountUsecase _getWalletAmountUsecase;
  final TokenSharedPrefs _tokenSharedPrefs;

  HomeCubit(
    this._getAllProjectsUsecase,
    this._getAllSkillsUsecase,
    this._getFreelancerByIdUsecase,
    this._getWalletAmountUsecase,
    this._tokenSharedPrefs,
  ) : super(HomeState.initial()) {
    fetchFreelancerProfile();
  }

  void selectTab(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  Future<void> fetchProjects() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getAllProjectsUsecase(const NoParams());

    result.fold(
      (failure) {
        debugPrint(" Error fetching projects: ${failure.toString()}");
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.toString(),
        ));
      },
      (projects) {
        for (var project in projects) {
          debugPrint('Fetched Project ID: ${project.projectId}');
        }
        emit(state.copyWith(isLoading: false, projects: projects));
      },
    );
  }

  Future<void> fetchSkills() async {
    emit(state.copyWith(isSkillsLoading: true));

    final result = await _getAllSkillsUsecase();

    result.fold(
      (failure) {
        debugPrint(" Error fetching skills: ${failure.toString()}");
        emit(state.copyWith(
          isSkillsLoading: false,
          skillsErrorMessage: failure.toString(),
        ));
      },
      (skills) {
        emit(state.copyWith(isSkillsLoading: false, skills: skills));
      },
    );
  }

  Future<void> fetchFreelancerProfile() async {
    final userIdResult = await _tokenSharedPrefs.getUserId();

    userIdResult.fold(
      (failure) {
        debugPrint(" Failed to retrieve userId: ${failure.toString()}");
      },
      (userId) async {
        if (userId.isEmpty) {
          debugPrint("User ID not found in SharedPreferences");
          return;
        }

        debugPrint(" Fetching freelancer profile for user ID: $userId");

        final freelancerResult = await _getFreelancerByIdUsecase(
            GetFreelancerByIdParams(freelancerId: userId));

        freelancerResult.fold(
          (failure) {
            debugPrint(
                " Error fetching freelancer profile: ${failure.toString()}");
          },
          (freelancer) {
            debugPrint(
                " Freelancer Profile Fetched: ${freelancer.freelancerName}");
            emit(state.copyWith(freelancer: freelancer));
          },
        );
      },
    );
  }

  Future<void> fetchWalletAmount() async {
    final userIdResult = await _tokenSharedPrefs.getUserId();

    userIdResult.fold(
      (failure) {
        debugPrint(" Failed to retrieve userId: ${failure.toString()}");
        emit(state.copyWith(walletErrorMessage: failure.toString()));
      },
      (userId) async {
        if (userId.isEmpty) {
          debugPrint("User ID not found in SharedPreferences");
          emit(state.copyWith(walletErrorMessage: "User ID not found"));
          return;
        }

        debugPrint(" Fetching wallet amount for user ID: $userId");

        final walletResult = await _getWalletAmountUsecase(
            GetWalletAmountParams(walletId: userId));

        walletResult.fold(
          (failure) {
            debugPrint(" Error fetching wallet amount: ${failure.toString()}");
            emit(state.copyWith(walletErrorMessage: failure.toString()));
          },
          (wallet) {
            debugPrint(" Wallet Amount Fetched: ${wallet.amount}");
            emit(state.copyWith(walletAmount: wallet.amount));
          },
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    emit(state.copyWith(isLoggingOut: true));

    await _tokenSharedPrefs.clearTokenAndUserId();

    emit(HomeState.initial());

    Navigator.pushReplacementNamed(context, '/login');
  }

  void setSelectedSkill(String? skill) {
    emit(state.copyWith(selectedSkill: skill));
  }
}
