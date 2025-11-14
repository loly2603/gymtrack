import 'package:gymtrack/services/workout_service.dart';
import 'package:gymtrack/services/auth_service.dart';

class AdminService {
  static final AdminService _instance = AdminService._internal();

  factory AdminService() {
    return _instance;
  }

  AdminService._internal();

  final WorkoutService _workoutService = WorkoutService();
  final AuthService _authService = AuthService();

  // Datos globales del sistema
  Map<String, dynamic> getGlobalStats() {
    final workouts = _workoutService.workouts;
    final stats = _workoutService.getStats();

    // Calcular usuarios únicos (simulado: siempre 3 en demo)
    final totalUsers = 3;
    final activeUsers = 1; // Usuario actual

    // Estadísticas por mes (simulado)
    int thisMonthWorkouts = 0;
    int thisWeekWorkouts = 0;
    final now = DateTime.now();

    for (var workout in workouts) {
      final difference = now.difference(workout.date).inDays;
      if (difference <= 30) thisMonthWorkouts++;
      if (difference <= 7) thisWeekWorkouts++;
    }

    return {
      'totalUsers': totalUsers,
      'activeUsers': activeUsers,
      'totalWorkouts': stats['totalWorkouts'] ?? 0,
      'thisMonthWorkouts': thisMonthWorkouts,
      'thisWeekWorkouts': thisWeekWorkouts,
      'totalDuration': stats['totalDuration'] ?? 0,
      'totalExercises': stats['totalExercises'] ?? 0,
      'totalVolume': stats['totalVolume'] ?? '0',
      'averageWorkoutDuration': _calculateAverageWorkoutDuration(),
    };
  }

  int _calculateAverageWorkoutDuration() {
    final workouts = _workoutService.workouts;
    if (workouts.isEmpty) return 0;

    int totalMinutes = 0;
    for (var workout in workouts) {
      totalMinutes += workout.duration.inMinutes;
    }
    return (totalMinutes / workouts.length).toInt();
  }

  // Obtener listado de todos los usuarios registrados (demo)
  List<Map<String, String>> getAllUsers() {
    return [
      {
        'name': 'Admin User',
        'email': 'admin@gymtrack.com',
        'role': 'admin',
        'status': 'Activo',
      },
      {
        'name': 'Instructor User',
        'email': 'instructor@gymtrack.com',
        'role': 'instructor',
        'status': 'Activo',
      },
      {
        'name': 'Regular User',
        'email': 'user@gymtrack.com',
        'role': 'user',
        'status': 'Activo',
      },
    ];
  }

  // Obtener los últimos entrenamientos (para auditoría)
  List getRecentActivity() {
    final workouts = _workoutService.getWorkoutsSorted().take(5).toList();
    return workouts
        .map((w) => {
      'type': 'workout',
      'description': '${w.name} - ${w.exercises.length} ejercicios',
      'date': w.date,
      'user': 'Usuario Demo',
    })
        .toList();
  }
}