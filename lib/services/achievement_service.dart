class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final bool unlocked;
  final DateTime? unlockedDate;
  final double progress;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.unlocked,
    this.unlockedDate,
    required this.progress,
  });
}

class AchievementService {
  static final AchievementService _instance = AchievementService._internal();

  factory AchievementService() {
    return _instance;
  }

  AchievementService._internal();

  List<Achievement> getAchievements(String userId) {
    final now = DateTime.now();

    return [
      Achievement(
        id: 'first-workout',
        title: 'Primer Entrenamiento',
        description: 'Completa tu primer entrenamiento',
        icon: '🎯',
        unlocked: true,
        unlockedDate: now.subtract(const Duration(days: 45)),
        progress: 1.0,
      ),
      Achievement(
        id: 'week-streak',
        title: 'Una Semana Consecutiva',
        description: 'Entrena 7 días consecutivos',
        icon: '🔥',
        unlocked: true,
        unlockedDate: now.subtract(const Duration(days: 30)),
        progress: 1.0,
      ),
      Achievement(
        id: 'hundred-kg',
        title: 'Centena de Kilogramos',
        description: 'Levanta 100kg en una sesión',
        icon: '💪',
        unlocked: true,
        unlockedDate: now.subtract(const Duration(days: 20)),
        progress: 1.0,
      ),
      Achievement(
        id: 'month-streak',
        title: 'Mes Consecutivo',
        description: 'Entrena 30 días consecutivos',
        icon: '🏆',
        unlocked: true,
        unlockedDate: now.subtract(const Duration(days: 15)),
        progress: 1.0,
      ),
      Achievement(
        id: 'beast-mode',
        title: 'Modo Beast',
        description: 'Levanta 500kg en una sesión',
        icon: '⚡',
        unlocked: false,
        progress: 0.65,
      ),
      Achievement(
        id: 'marathon',
        title: 'Maratón Fitness',
        description: 'Acumula 100 horas de entrenamiento',
        icon: '🏅',
        unlocked: false,
        progress: 0.625,
      ),
      Achievement(
        id: 'legend',
        title: 'Leyenda',
        description: 'Alcanza 100 entrenamientos',
        icon: '👑',
        unlocked: false,
        progress: 0.12,
      ),
      Achievement(
        id: 'consistency',
        title: 'Consistencia Absoluta',
        description: 'Mantén una racha de 100 días',
        icon: '✨',
        unlocked: false,
        progress: 0.12,
      ),
    ];
  }

  List<Achievement> getUnlockedAchievements(String userId) {
    return getAchievements(userId).where((a) => a.unlocked).toList();
  }

  List<Achievement> getLockedAchievements(String userId) {
    return getAchievements(userId).where((a) => !a.unlocked).toList();
  }

  Achievement? getAchievementById(String userId, String achievementId) {
    try {
      return getAchievements(userId)
          .firstWhere((a) => a.id == achievementId);
    } catch (e) {
      return null;
    }
  }
}