import 'package:flutter/material.dart';
import 'package:projectsyeti/views/account_view.dart';
import 'package:projectsyeti/views/home_view.dart';
import 'package:projectsyeti/views/chat_view.dart';
import 'package:projectsyeti/views/wallet_view.dart';

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
              Icons.person,
              size: 30,
              color: currentIndex == 3 ? Colors.white : Colors.grey,
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

  final List<Widget> _screens = [
    const HomeView(),
    const ChatView(),
    const WalletView(),
    const AccountView(),
  ];

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
