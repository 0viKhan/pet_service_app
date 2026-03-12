import 'package:flutter/material.dart';
import 'package:untitled1/features/home/view/home_view.dart';
import 'package:untitled1/features/home/view/professionals_view.dart';
import 'package:untitled1/features/nav_bar/bottom_nav_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  final List<Widget> screens = [
     HomeView(),
    const Scaffold(body: Center(child: Text('Map Screen'))),
    const ProfessionalsView(),
    const Scaffold(body: Center(child: Text('Profile Screen'))),
  ];

  void onNavTap(int index) {
    if (index == 4) {
      // add button action
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