import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/placeholder_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/workouts_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/register_screen.dart';

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
        '/': (context) => const DashboardScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/workouts': (context) => const WorkoutsScreen(),
        '/progress': (context) => const ProgressScreen(),
        '/goals': (context) => const PlaceholderScreen(
          title: 'Objetivos',
          description: 'Establece y realiza un seguimiento de tus objetivos fitness. Monitorea tu progreso.',
          icon: Icons.track_changes,
        ),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}