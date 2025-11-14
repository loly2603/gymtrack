import 'package:gymtrack/models/workout_model.dart';
import 'package:uuid/uuid.dart';

class ProgressData {
  final DateTime date;
  final double volume;
  final int exerciseCount;
  final int duration;

  ProgressData({
    required this.date,
    required this.volume,
    required this.exerciseCount,
    required this.duration,
  });
}

class WorkoutStats {
  final int totalWorkouts;
  final double totalVolume;
  final int totalDuration;
  final int totalExercises;
  final int streakDays;
  final double averageWeight;

  WorkoutStats({
    required this.totalWorkouts,
    required this.totalVolume,
    required this.totalDuration,
    required this.totalExercises,
    required this.streakDays,
    required this.averageWeight,
  });
}

class WorkoutService {
  static final WorkoutService _instance = WorkoutService._internal();
  final List<Workout> _workouts = [];

  factory WorkoutService() {
    return _instance;
  }

  WorkoutService._internal() {
    _initializeDemoData();
  }

  void _initializeDemoData() {
    _workouts.clear();
    final now = DateTime.now();
    const uuid = Uuid();

    final demoWorkouts = [
      Workout(
        id: uuid.v4(),
        name: 'Pecho & Tríceps',
        date: now.subtract(const Duration(days: 0, hours: 2)),
        duration: const Duration(minutes: 75),
        exercises: [
          Exercise(name: 'Bench Press', sets: 4, reps: 8, weight: 100),
          Exercise(name: 'Incline Dumbbell', sets: 3, reps: 10, weight: 40),
          Exercise(name: 'Cable Flyes', sets: 3, reps: 12, weight: 30),
          Exercise(name: 'Tricep Dips', sets: 3, reps: 10, weight: 50),
          Exercise(name: 'Rope Pushdown', sets: 3, reps: 12, weight: 40),
          Exercise(name: 'Tricep Curls', sets: 3, reps: 12, weight: 25),
          Exercise(name: 'Machine Chest Press', sets: 3, reps: 10, weight: 120),
          Exercise(name: 'Overhead Press', sets: 3, reps: 8, weight: 50),
        ],
        notes: 'Excelente sesión, mucha energía',
      ),
      Workout(
        id: uuid.v4(),
        name: 'Espalda & Bíceps',
        date: now.subtract(const Duration(days: 1, hours: 3)),
        duration: const Duration(minutes: 80),
        exercises: [
          Exercise(name: 'Deadlifts', sets: 4, reps: 6, weight: 140),
          Exercise(name: 'Bent Over Rows', sets: 4, reps: 8, weight: 100),
          Exercise(name: 'Pull-ups', sets: 3, reps: 10, weight: 0),
          Exercise(name: 'Barbell Curls', sets: 3, reps: 8, weight: 60),
          Exercise(name: 'Machine Rows', sets: 3, reps: 10, weight: 150),
          Exercise(name: 'Cable Rows', sets: 3, reps: 10, weight: 80),
          Exercise(name: 'Dumbbell Curls', sets: 3, reps: 10, weight: 30),
        ],
        notes: 'Buen volumen',
      ),
      Workout(
        id: uuid.v4(),
        name: 'Día de Piernas',
        date: now.subtract(const Duration(days: 2, hours: 4)),
        duration: const Duration(minutes: 90),
        exercises: [
          Exercise(name: 'Squats', sets: 5, reps: 6, weight: 150),
          Exercise(name: 'Leg Press', sets: 4, reps: 8, weight: 300),
          Exercise(name: 'Leg Curls', sets: 3, reps: 10, weight: 120),
          Exercise(name: 'Leg Extensions', sets: 3, reps: 12, weight: 100),
          Exercise(name: 'Calf Raises', sets: 4, reps: 12, weight: 200),
          Exercise(name: 'Walking Lunges', sets: 3, reps: 10, weight: 30),
          Exercise(name: 'Smith Machine Squats', sets: 3, reps: 10, weight: 120),
          Exercise(name: 'Hack Squat', sets: 3, reps: 10, weight: 150),
          Exercise(name: 'Glute Bridge', sets: 3, reps: 12, weight: 100),
        ],
        notes: 'Las piernas respondieron bien',
      ),
      Workout(
        id: uuid.v4(),
        name: 'Hombros & Brazos',
        date: now.subtract(const Duration(days: 3, hours: 5)),
        duration: const Duration(minutes: 70),
        exercises: [
          Exercise(name: 'Military Press', sets: 4, reps: 6, weight: 70),
          Exercise(name: 'Lateral Raises', sets: 3, reps: 12, weight: 20),
          Exercise(name: 'Reverse Flyes', sets: 3, reps: 12, weight: 15),
          Exercise(name: 'Dumbbell Shoulder Press', sets: 3, reps: 8, weight: 35),
          Exercise(name: 'Barbell Curls', sets: 3, reps: 8, weight: 60),
          Exercise(name: 'Hammer Curls', sets: 3, reps: 10, weight: 30),
          Exercise(name: 'Overhead Tricep Extension', sets: 3, reps: 10, weight: 35),
          Exercise(name: 'Machine Shoulder Press', sets: 3, reps: 10, weight: 100),
        ],
        notes: 'Sesión intensa',
      ),
      Workout(
        id: uuid.v4(),
        name: 'Pecho & Tríceps',
        date: now.subtract(const Duration(days: 4, hours: 2)),
        duration: const Duration(minutes: 75),
        exercises: [
          Exercise(name: 'Bench Press', sets: 4, reps: 8, weight: 105),
          Exercise(name: 'Incline Dumbbell', sets: 3, reps: 10, weight: 42),
          Exercise(name: 'Cable Flyes', sets: 3, reps: 12, weight: 32),
          Exercise(name: 'Tricep Dips', sets: 3, reps: 10, weight: 52),
          Exercise(name: 'Rope Pushdown', sets: 3, reps: 12, weight: 42),
          Exercise(name: 'Tricep Curls', sets: 3, reps: 12, weight: 27),
          Exercise(name: 'Machine Chest Press', sets: 3, reps: 10, weight: 125),
          Exercise(name: 'Overhead Press', sets: 3, reps: 8, weight: 52),
        ],
        notes: 'Progreso visible',
      ),
      Workout(
        id: uuid.v4(),
        name: 'Espalda & Bíceps',
        date: now.subtract(const Duration(days: 5, hours: 3)),
        duration: const Duration(minutes: 80),
        exercises: [
          Exercise(name: 'Deadlifts', sets: 4, reps: 6, weight: 135),
          Exercise(name: 'Bent Over Rows', sets: 4, reps: 8, weight: 95),
          Exercise(name: 'Pull-ups', sets: 3, reps: 10, weight: 0),
          Exercise(name: 'Barbell Curls', sets: 3, reps: 8, weight: 58),
          Exercise(name: 'Machine Rows', sets: 3, reps: 10, weight: 145),
          Exercise(name: 'Cable Rows', sets: 3, reps: 10, weight: 78),
          Exercise(name: 'Dumbbell Curls', sets: 3, reps: 10, weight: 28),
        ],
        notes: '',
      ),
      Workout(
        id: uuid.v4(),
        name: 'Día de Piernas',
        date: now.subtract(const Duration(days: 6, hours: 4)),
        duration: const Duration(minutes: 85),
        exercises: [
          Exercise(name: 'Squats', sets: 5, reps: 6, weight: 148),
          Exercise(name: 'Leg Press', sets: 4, reps: 8, weight: 295),
          Exercise(name: 'Leg Curls', sets: 3, reps: 10, weight: 115),
          Exercise(name: 'Leg Extensions', sets: 3, reps: 12, weight: 98),
          Exercise(name: 'Calf Raises', sets: 4, reps: 12, weight: 195),
          Exercise(name: 'Walking Lunges', sets: 3, reps: 10, weight: 28),
          Exercise(name: 'Smith Machine Squats', sets: 3, reps: 10, weight: 118),
          Exercise(name: 'Hack Squat', sets: 3, reps: 10, weight: 148),
          Exercise(name: 'Glute Bridge', sets: 3, reps: 12, weight: 98),
        ],
        notes: 'Excelente',
      ),
      Workout(
        id: uuid.v4(),
        name: 'Cardio & Core',
        date: now.subtract(const Duration(days: 7, hours: 1)),
        duration: const Duration(minutes: 60),
        exercises: [
          Exercise(name: 'Treadmill', sets: 1, reps: 1, weight: 0),
          Exercise(name: 'Abs Crunches', sets: 3, reps: 20, weight: 0),
          Exercise(name: 'Planks', sets: 3, reps: 1, weight: 0),
          Exercise(name: 'Russian Twists', sets: 3, reps: 20, weight: 10),
          Exercise(name: 'Leg Raises', sets: 3, reps: 15, weight: 0),
        ],
        notes: 'Sesión de recuperación',
      ),
      Workout(
        id: uuid.v4(),
        name: 'Hombros',
        date: now.subtract(const Duration(days: 8, hours: 5)),
        duration: const Duration(minutes: 65),
        exercises: [
          Exercise(name: 'Military Press', sets: 4, reps: 6, weight: 68),
          Exercise(name: 'Lateral Raises', sets: 3, reps: 12, weight: 18),
          Exercise(name: 'Reverse Flyes', sets: 3, reps: 12, weight: 13),
          Exercise(name: 'Dumbbell Shoulder Press', sets: 3, reps: 8, weight: 33),
          Exercise(name: 'Shrugs', sets: 3, reps: 10, weight: 40),
          Exercise(name: 'Machine Shoulder Press', sets: 3, reps: 10, weight: 95),
        ],
        notes: '',
      ),
      Workout(
        id: uuid.v4(),
        name: 'Pecho & Tríceps',
        date: now.subtract(const Duration(days: 9, hours: 3)),
        duration: const Duration(minutes: 75),
        exercises: [
          Exercise(name: 'Bench Press', sets: 4, reps: 8, weight: 102),
          Exercise(name: 'Incline Dumbbell', sets: 3, reps: 10, weight: 41),
          Exercise(name: 'Cable Flyes', sets: 3, reps: 12, weight: 31),
          Exercise(name: 'Tricep Dips', sets: 3, reps: 10, weight: 51),
          Exercise(name: 'Rope Pushdown', sets: 3, reps: 12, weight: 41),
          Exercise(name: 'Tricep Curls', sets: 3, reps: 12, weight: 26),
          Exercise(name: 'Machine Chest Press', sets: 3, reps: 10, weight: 122),
          Exercise(name: 'Overhead Press', sets: 3, reps: 8, weight: 51),
        ],
        notes: 'Buena forma',
      ),
      Workout(
        id: uuid.v4(),
        name: 'Espalda',
        date: now.subtract(const Duration(days: 10, hours: 2)),
        duration: const Duration(minutes: 80),
        exercises: [
          Exercise(name: 'Deadlifts', sets: 4, reps: 6, weight: 138),
          Exercise(name: 'Bent Over Rows', sets: 4, reps: 8, weight: 98),
          Exercise(name: 'Pull-ups', sets: 3, reps: 10, weight: 0),
          Exercise(name: 'Barbell Curls', sets: 3, reps: 8, weight: 59),
          Exercise(name: 'Machine Rows', sets: 3, reps: 10, weight: 148),
          Exercise(name: 'Cable Rows', sets: 3, reps: 10, weight: 79),
          Exercise(name: 'Dumbbell Curls', sets: 3, reps: 10, weight: 29),
        ],
        notes: '',
      ),
      Workout(
        id: uuid.v4(),
        name: 'Piernas',
        date: now.subtract(const Duration(days: 11, hours: 4)),
        duration: const Duration(minutes: 90),
        exercises: [
          Exercise(name: 'Squats', sets: 5, reps: 6, weight: 152),
          Exercise(name: 'Leg Press', sets: 4, reps: 8, weight: 305),
          Exercise(name: 'Leg Curls', sets: 3, reps: 10, weight: 125),
          Exercise(name: 'Leg Extensions', sets: 3, reps: 12, weight: 105),
          Exercise(name: 'Calf Raises', sets: 4, reps: 12, weight: 205),
          Exercise(name: 'Walking Lunges', sets: 3, reps: 10, weight: 32),
          Exercise(name: 'Smith Machine Squats', sets: 3, reps: 10, weight: 128),
          Exercise(name: 'Hack Squat', sets: 3, reps: 10, weight: 160),
          Exercise(name: 'Glute Bridge', sets: 3, reps: 12, weight: 105),
        ],
        notes: 'Intenso',
      ),
    ];

    _workouts.addAll(demoWorkouts);
  }

  // Obtener todos los entrenamientos
  List<Workout> get workouts => _workouts;

  // Obtener entrenamientos ordenados por fecha (más recientes primero)
  List<Workout> getWorkoutsSorted() {
    final sorted = List<Workout>.from(_workouts);
    sorted.sort((a, b) => b.date.compareTo(a.date));
    return sorted;
  }

  // Agregar entrenamiento
  void addWorkout(Workout workout) {
    _workouts.add(workout);
  }

  // Crear nuevo entrenamiento con ID único
  Workout createWorkout({
    required String name,
    required DateTime date,
    required Duration duration,
    required List<Exercise> exercises,
    String? notes,
  }) {
    const uuid = Uuid();
    final workout = Workout(
      id: uuid.v4(),
      name: name,
      date: date,
      duration: duration,
      exercises: exercises,
      notes: notes,
    );
    addWorkout(workout);
    return workout;
  }

  // Obtener entrenamiento por ID
  Workout? getWorkoutById(String id) {
    try {
      return _workouts.firstWhere((w) => w.id == id);
    } catch (e) {
      return null;
    }
  }

  // Eliminar entrenamiento
  void deleteWorkout(String id) {
    _workouts.removeWhere((w) => w.id == id);
  }

  // Actualizar entrenamiento
  void updateWorkout(Workout workout) {
    final index = _workouts.indexWhere((w) => w.id == workout.id);
    if (index != -1) {
      _workouts[index] = workout;
    }
  }

  // Obtener estadísticas antiguas (compatibilidad)
  Map<String, dynamic> getStats() {
    if (_workouts.isEmpty) {
      return {
        'totalWorkouts': 0,
        'totalDuration': 0,
        'totalExercises': 0,
        'totalVolume': '0.0',
      };
    }

    int totalDuration = 0;
    int totalExercises = 0;
    double totalVolume = 0.0;

    for (var workout in _workouts) {
      totalDuration += workout.duration.inMinutes;
      totalExercises += workout.exercises.length;
      for (var exercise in workout.exercises) {
        totalVolume += exercise.sets * exercise.reps * exercise.weight;
      }
    }

    return {
      'totalWorkouts': _workouts.length,
      'totalDuration': totalDuration,
      'totalExercises': totalExercises,
      'totalVolume': totalVolume.toStringAsFixed(1),
    };
  }

  // Nuevos métodos para gráficos y estadísticas avanzadas
  WorkoutStats getWorkoutStats() {
    if (_workouts.isEmpty) {
      return WorkoutStats(
        totalWorkouts: 0,
        totalVolume: 0,
        totalDuration: 0,
        totalExercises: 0,
        streakDays: 0,
        averageWeight: 0,
      );
    }

    int totalDuration = 0;
    int totalExercises = 0;
    double totalVolume = 0.0;

    for (var workout in _workouts) {
      totalDuration += workout.duration.inMinutes;
      totalExercises += workout.exercises.length;
      for (var exercise in workout.exercises) {
        totalVolume += exercise.sets * exercise.reps * exercise.weight;
      }
    }

    double averageWeight = totalVolume / (_workouts.length > 0 ? _workouts.length : 1);

    // Calcular racha de días consecutivos
    int streakDays = 0;
    final now = DateTime.now();
    for (int i = 0; i < 365; i++) {
      final checkDate = now.subtract(Duration(days: i));
      final hasWorkout = _workouts.any((w) =>
      w.date.year == checkDate.year &&
          w.date.month == checkDate.month &&
          w.date.day == checkDate.day);

      if (hasWorkout) {
        streakDays++;
      } else if (i > 0) {
        break;
      }
    }

    return WorkoutStats(
      totalWorkouts: _workouts.length,
      totalVolume: totalVolume,
      totalDuration: totalDuration,
      totalExercises: totalExercises,
      streakDays: streakDays,
      averageWeight: averageWeight,
    );
  }

  // Obtener datos de progreso para gráficos
  List<ProgressData> getProgressData(int days) {
    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: days));

    final workoutsInRange = _workouts
        .where((w) =>
    w.date.isAfter(startDate) &&
        w.date.isBefore(now.add(const Duration(days: 1))))
        .toList();

    final progressMap = <int, ProgressData>{};

    for (int i = days; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateKey = date.year * 10000 + date.month * 100 + date.day;

      final dayWorkouts = workoutsInRange
          .where((w) =>
      w.date.year == date.year &&
          w.date.month == date.month &&
          w.date.day == date.day)
          .toList();

      double volume = 0;
      int exercises = 0;
      int duration = 0;

      for (var workout in dayWorkouts) {
        duration += workout.duration.inMinutes;
        exercises += workout.exercises.length;
        for (var exercise in workout.exercises) {
          volume += exercise.sets * exercise.reps * exercise.weight;
        }
      }

      progressMap[dateKey] = ProgressData(
        date: date,
        volume: volume,
        exerciseCount: exercises,
        duration: duration,
      );
    }

    return progressMap.values.toList();
  }

  // Obtener entrenamientos de un usuario (por compatibilidad, devuelve todos)
  List<Workout> getWorkouts(String userId) {
    return _workouts;
  }
}