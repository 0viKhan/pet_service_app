import 'package:flutter/material.dart';

import 'features/auth/profile/view/profile_screen.dart';
import 'features/home/view/home_view.dart';
import 'features/home/view/professionals_view.dart';
import 'features/nav_bar/bottom_nav_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeView(),
    const Scaffold(
      body: Center(child: Text('Map Screen')),
    ),
    const ProfessionalsView(),
    const ProfileView(),
  ];

  void onNavTap(int index) {
    if (index == 4) {
      // center add button action
      return;
    }

    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: onNavTap,
      ),
    );
  }
}