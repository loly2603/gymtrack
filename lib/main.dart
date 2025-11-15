import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/main_scaffold.dart';
import 'widgets/admin_main_scaffold.dart';
import 'screens/login_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/register_screen.dart';
import 'screens/goals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymTrack - Fitness',
      theme: AppTheme.darkTheme,
      initialRoute: '/login',
      routes: {
        '/': (context) => const MainScaffold(initialIndex: 0),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/dashboard': (context) => const MainScaffold(initialIndex: 0),
        '/workouts': (context) => const MainScaffold(initialIndex: 1),
        '/progress': (context) => const MainScaffold(initialIndex: 2),
        '/goals': (context) => const MainScaffold(initialIndex: 3),
        '/profile': (context) => const MainScaffold(initialIndex: 4),
        '/admin': (context) => const AdminMainScaffold(initialIndex: 0),
        '/admin/workouts': (context) => const AdminMainScaffold(initialIndex: 1),
        '/admin/progress': (context) => const AdminMainScaffold(initialIndex: 2),
        '/admin/profile': (context) => const AdminMainScaffold(initialIndex: 3),
      },
    );
  }
}