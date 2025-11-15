import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';
import '../screens/workouts_screen.dart';
import '../screens/progress_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/goals_screen.dart';

class MainScaffold extends StatefulWidget {
  final int initialIndex;
  const MainScaffold({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late int _selectedIndex;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _pages = [
      const DashboardScreen(),
      const WorkoutsScreen(),
      const ProgressScreen(),
      const GoalsScreen(),
      const ProfileScreen(),
    ];
  }

  void _onTap(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.track_changes), label: 'Goals'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

