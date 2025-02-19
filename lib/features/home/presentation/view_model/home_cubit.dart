import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/project/domain/use_case/get_all_projects_usecase.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAllProjectsUsecase _getAllProjectsUsecase;

  HomeCubit(this._getAllProjectsUsecase) : super(HomeState.initial());

  void selectTab(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

Future<void> fetchProjects() async {
  emit(state.copyWith(isLoading: true, errorMessage: null));

  final result = await _getAllProjectsUsecase(const NoParams());

  result.fold(
    (failure) {
      debugPrint("Error fetching projects: ${failure.toString()}");
      emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.toString(), 
      ));
    },
    (projects) {
      for (var project in projects) {
        debugPrint('✅ Fetched Project ID: ${project.projectId}');
      }
      emit(state.copyWith(isLoading: false, projects: projects));
    },
  );
}

}