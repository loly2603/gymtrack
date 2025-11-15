import 'package:flutter/material.dart';
import '../screens/admin_dashboard_screen.dart';
import '../screens/workouts_screen.dart';
import '../screens/progress_screen.dart';
import '../screens/profile_screen.dart';

class AdminMainScaffold extends StatefulWidget {
  final int initialIndex;
  const AdminMainScaffold({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<AdminMainScaffold> createState() => _AdminMainScaffoldState();
}

class _AdminMainScaffoldState extends State<AdminMainScaffold> {
  late int _selectedIndex;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _pages = [
      const AdminDashboardScreen(),
      const WorkoutsScreen(),
      const ProgressScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Admin'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

