import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projectsyeti/features/home/presentation/view/account_view.dart';
import 'package:projectsyeti/features/home/presentation/view/chat_view.dart';
import 'package:projectsyeti/features/home/presentation/view/dashboard_view.dart';
import 'package:projectsyeti/features/home/presentation/view/home_view.dart';
import 'package:projectsyeti/features/home/presentation/view/wallet_view.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  static HomeState initial() {
    return const HomeState(
      selectedIndex: 0,
      views: [
        HomeView(),
        ChatView(),
        DashboardView(),
        WalletView(),
        HomeView(),
        AccountView(),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
