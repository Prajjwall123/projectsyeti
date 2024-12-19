import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 2, 44, 78),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(size: 30, Icons.home, color: Colors.white),
          Icon(size: 30, Icons.message, color: Colors.white),
          Icon(size: 30, Icons.wallet, color: Colors.white),
          Icon(size: 30, Icons.person, color: Colors.white),
        ],
      ),
    );
  }
}
