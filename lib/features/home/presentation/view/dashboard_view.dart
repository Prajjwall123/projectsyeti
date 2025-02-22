import 'package:flutter/material.dart';
import 'package:projectsyeti/app/shared_prefs/token_shared_prefs.dart';
import 'package:projectsyeti/core/common/snackbar/my_snackbar.dart';
import 'package:projectsyeti/features/freelancer/presentation/view/freelancer_view.dart';
import 'package:projectsyeti/features/home/presentation/view/chat_view.dart';
import 'package:projectsyeti/features/home/presentation/view/home_view.dart';
import 'package:projectsyeti/features/home/presentation/view/notification_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const NavigationMenu(
      {super.key, required this.currentIndex, required this.onTabSelected});

  Widget _navItem(BuildContext context, IconData icon, int index) {
    bool active = currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTabSelected(index);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            size: 28,
            color:
                active ? Theme.of(context).colorScheme.primary : Colors.white70,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF001F3F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(context, Icons.home, 0),
          _navItem(context, Icons.message, 1),
          _navItem(context, Icons.notifications, 2),
          _navItem(context, Icons.person, 3),
        ],
      ),
    );
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentIndex = 0;
  late TokenSharedPrefs tokenSharedPrefs;

  final List<Widget> _screens = [
    const HomeView(),
    const ChatView(),
    const NotificationView(),
    const FreelancerView(freelancerId: ""),
  ];

  @override
  void initState() {
    super.initState();
    _initializeTokenSharedPrefs();
  }

  void _initializeTokenSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenSharedPrefs = TokenSharedPrefs(prefs);
    _getUserIdAndUpdateFreelancerView();
  }

  void _getUserIdAndUpdateFreelancerView() async {
    final userIdResult = await tokenSharedPrefs.getUserId();

    userIdResult.fold(
      (failure) {
        // Handle failure
        showMySnackBar(
          context: context,
          message: "Failed to retrieve userId",
          color: Colors.red,
        );
      },
      (userId) {
        if (userId.isNotEmpty) {
          setState(() {
            _screens[3] = FreelancerView(freelancerId: userId);
          });
        } else {
          showMySnackBar(
            context: context,
            message: "User ID not found in SharedPreferences",
            color: Colors.red,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFEFEFEF),
      body: _screens[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NavigationMenu(
          currentIndex: _currentIndex,
          onTabSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
