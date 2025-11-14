class Workout {
  final String id;
  final String name;
  final DateTime date;
  final Duration duration;
  final List<Exercise> exercises;
  final String? notes;

  Workout({
    required this.id,
    required this.name,
    required this.date,
    required this.duration,
    required this.exercises,
    this.notes,
  });

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'duration': duration.inMinutes,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'notes': notes,
    };
  }

  // Crear desde JSON
  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      duration: Duration(minutes: json['duration'] ?? 0),
      exercises: (json['exercises'] as List?)?.map((e) => Exercise.fromJson(e)).toList() ?? [],
      notes: json['notes'],
    );
  }
}

class Exercise {
  final String name;
  final int sets;
  final int reps;
  final double weight; // en kg

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
  });

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sets': sets,
      'reps': reps,
      'weight': weight,
    };
  }

  // Crear desde JSON
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] ?? '',
      sets: json['sets'] ?? 0,
      reps: json['reps'] ?? 0,
      weight: (json['weight'] ?? 0).toDouble(),
    );
  }
}