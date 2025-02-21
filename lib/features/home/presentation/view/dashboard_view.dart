import 'package:flutter/material.dart';
import 'package:projectsyeti/app/shared_prefs/token_shared_prefs.dart';
import 'package:projectsyeti/core/common/snackbar/my_snackbar.dart';
import 'package:projectsyeti/features/freelancer/presentation/view/freelancer_view.dart';
import 'package:projectsyeti/features/home/presentation/view/chat_view.dart';
import 'package:projectsyeti/features/home/presentation/view/home_view.dart';
import 'package:projectsyeti/features/home/presentation/view/wallet_view.dart';
import 'package:projectsyeti/features/company/presentation/view/company_view.dart';
import 'package:projectsyeti/features/project/presentation/view/project_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationMenu extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const NavigationMenu({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 2, 44, 78),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => onTabSelected(0),
            child: Icon(
              Icons.home,
              size: 30,
              color: currentIndex == 0 ? Colors.white : Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () => onTabSelected(1),
            child: Icon(
              Icons.message,
              size: 30,
              color: currentIndex == 1 ? Colors.white : Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () => onTabSelected(2),
            child: Icon(
              Icons.wallet,
              size: 30,
              color: currentIndex == 2 ? Colors.white : Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () => onTabSelected(3),
            child: Icon(
              Icons.business,
              size: 30,
              color: currentIndex == 3 ? Colors.white : Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () => onTabSelected(4),
            child: Icon(
              Icons.folder,
              size: 30,
              color: currentIndex == 4 ? Colors.white : Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () => onTabSelected(5),
            child: Icon(
              Icons.person,
              size: 30,
              color: currentIndex == 5 ? Colors.white : Colors.grey,
            ),
          ),
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
    const WalletView(),
    const CompanyView(companyId: "679e52a2570ca2c950216916"),
    const ProjectView(projectId: "67a7124f2930204713f5da92"),
    const FreelancerView(freelancerId: ""), // Placeholder for now
  ];

  @override
  void initState() {
    super.initState();
    _initializeTokenSharedPrefs();
  }

  // Initialize the TokenSharedPrefs with the SharedPreferences instance
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
            _screens[5] = FreelancerView(
                freelancerId:
                    userId); 
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
