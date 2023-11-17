import 'package:ambeego_test/features/timer/presentation/screens/focus_history.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../timer/presentation/screens/timer.screen.dart';

class BottomNavigationScreen extends StatefulHookWidget {
  static const String routeName = "/bottom_nav_screen";
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomNavIndex == 1 ? const FocusHistoryScreen() : const TimerScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: 'Work History',
          ),
        ],
        onTap: (index) {
          // Navigate to the selected screen.
          bottomNavIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
