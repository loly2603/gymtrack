import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import '../services/workout_service.dart';
import '../services/achievement_service.dart';
import '../models/workout_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late AuthService _authService;
  late WorkoutService _workoutService;
  late AchievementService _achievementService;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _workoutService = WorkoutService();
    _achievementService = AchievementService();
  }


  // Helper to safely parse numbers (fixes toStringAsFixed on String)
  double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? 0.0;
    try {
      return double.tryParse(v.toString()) ?? 0.0;
    } catch (_) {
      return 0.0;
    }
  }

  String _formatNumber(dynamic v, [int decimals = 0]) {
    return _toDouble(v).toStringAsFixed(decimals);
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/login');
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final String uid;
    if (user.id is int) {
      uid = (user.id as int).toString();
    } else if (user.id is String) {
      uid = user.id as String;
    } else {
      uid = '0';
    }

    final workouts = _workoutService.getWorkouts(uid);
    final Map<String, dynamic>? stats = _workoutService.getStats();
    final int uidInt = int.tryParse(uid) ?? 0;
    final progressData = _workoutService.getProgressData(uidInt);

    final recent = progressData.length > 7
        ? progressData.sublist(progressData.length - 7)
        : progressData;

    double _extractVolume(dynamic p) {
      try {
        if (p == null) return 0.0;
        if (p is Map) {
          final v = p['volume'];
          if (v is num) return v.toDouble();
          if (v is String) return double.tryParse(v) ?? 0.0;
        } else {
          final dynamic v = (p as dynamic).volume;
          if (v is num) return v.toDouble();
          if (v is String) return double.tryParse(v) ?? 0.0;
        }
      } catch (_) {}
      return 0.0;
    }

    final chartData = recent.map<double>(_extractVolume).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.neonYellow,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.home, color: AppTheme.darkBackground),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.darkCard,
                border: Border(bottom: BorderSide(color: AppTheme.darkBorder)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.neonYellow,
                    radius: 28,
                    child: Text(
                      (user.name != null && user.name!.isNotEmpty) ? user.name![0].toUpperCase() : 'U',
                      style: const TextStyle(fontSize: 24, color: AppTheme.darkBackground, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¡Hola, ${user.name ?? 'Usuario'}!',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.lightText),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Sigue entrenando duro 💪',
                          style: TextStyle(color: AppTheme.mutedText, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resumen',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.lightText),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.5,
                    children: [
                      _MetricCard(
                        title: 'Volumen Total',
                        value: _formatNumber(stats?['totalVolume'], 0),
                        unit: 'kg',
                        icon: Icons.fitness_center,
                        iconColor: AppTheme.neonYellow,
                      ),
                      _MetricCard(
                        title: 'Entrenamientos',
                        value: _formatNumber(stats?['totalWorkouts'], 0),
                        unit: 'sesiones',
                        icon: Icons.repeat,
                        iconColor: Colors.greenAccent,
                      ),
                      _MetricCard(
                        title: 'Tiempo Total',
                        value: _formatNumber(stats?['totalDuration'], 0),
                        unit: 'min',
                        icon: Icons.access_time,
                        iconColor: Colors.lightBlueAccent,
                      ),
                      _MetricCard(
                        title: 'Calorías',
                        value: _formatNumber(stats?['totalCalories'], 0),
                        unit: 'kcal',
                        icon: Icons.local_fire_department,
                        iconColor: Colors.orangeAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.darkCard,
                border: Border(
                  top: BorderSide(color: AppTheme.darkBorder),
                  bottom: BorderSide(color: AppTheme.darkBorder),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Progreso Semanal',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.lightText),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppTheme.darkBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.darkBorder),
                    ),
                    child: chartData.isEmpty
                        ? Center(
                      child: Text(
                        'Sin datos disponibles',
                        style: TextStyle(color: AppTheme.mutedText),
                      ),
                    )
                        : CustomPaint(
                      painter: MiniChartPainter(
                        data: chartData,
                        maxValue: chartData.isEmpty ? 1.0 : chartData.reduce((a, b) => a > b ? a : b) * 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Entrenamientos Recientes',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.lightText),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/workouts'),
                        child: const Text('Ver todos'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  workouts.isEmpty
                      ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        'No hay entrenamientos registrados',
                        style: TextStyle(color: AppTheme.mutedText, fontSize: 14),
                      ),
                    ),
                  )
                      : Column(
                    children: workouts.take(3).map((workout) {
                      return _RecentWorkoutCard(workout: workout);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color iconColor;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: AppTheme.mutedText, fontSize: 11),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      color: iconColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      unit,
                      style: TextStyle(color: AppTheme.mutedText, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentWorkoutCard extends StatelessWidget {
  final Workout workout;

  const _RecentWorkoutCard({required this.workout});

  String _getTimeAgoString(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return 'Hace ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Hace ${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays}d';
    } else {
      return 'Hace ${(difference.inDays / 7).floor()}sem';
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeAgo = _getTimeAgoString(workout.date);
    final totalWeight = workout.exercises.fold<double>(
      0.0,
      (sum, exercise) => sum + (exercise.weight * exercise.sets * exercise.reps),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.darkBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.neonYellow.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.fitness_center, color: AppTheme.neonYellow, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.name,
                  style: const TextStyle(
                    color: AppTheme.lightText,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$timeAgo • ${workout.duration.inMinutes} min • ${workout.exercises.length} ejercicios',
                  style: TextStyle(color: AppTheme.mutedText, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.darkBackground,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${totalWeight.toStringAsFixed(0)} kg',
              style: const TextStyle(
                color: AppTheme.neonYellow,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MiniChartPainter extends CustomPainter {
  final List<double> data;
  final double maxValue;

  MiniChartPainter({required this.data, required this.maxValue});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty || maxValue == 0) return;

    final paint = Paint()
      ..color = AppTheme.neonYellow
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = AppTheme.neonYellow.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final stepX = size.width / (data.length - 1);
    final padding = 20.0;

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - padding - ((data[i] / maxValue) * (size.height - 2 * padding));

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height - padding);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height - padding);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    final pointPaint = Paint()
      ..color = AppTheme.neonYellow
      ..style = PaintingStyle.fill;

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - padding - ((data[i] / maxValue) * (size.height - 2 * padding));
      canvas.drawCircle(Offset(x, y), 3, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

