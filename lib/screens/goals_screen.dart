import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final List<Map<String, dynamic>> goals = [
    {
      'title': 'Aumentar volumen',
      'description': 'Llegar a 100kg de volumen total semanal',
      'progress': 0.65,
      'icon': Icons.trending_up,
      'color': Colors.blueAccent,
      'deadline': '15 Dic 2025',
    },
    {
      'title': 'Consistencia',
      'description': 'Entrenar 4 veces a la semana durante 30 días',
      'progress': 0.80,
      'icon': Icons.calendar_today,
      'color': Colors.greenAccent,
      'deadline': '30 Nov 2025',
    },
    {
      'title': 'Fuerza máxima',
      'description': 'Aumentar peso en sentadilla a 150kg',
      'progress': 0.45,
      'icon': Icons.fitness_center,
      'color': Colors.orangeAccent,
      'deadline': '31 Dic 2025',
    },
    {
      'title': 'Resistencia',
      'description': 'Completar 20 entrenamientos cardio',
      'progress': 0.35,
      'icon': Icons.favorite,
      'color': Colors.redAccent,
      'deadline': '15 Dic 2025',
    },
  ];

  void _editGoal(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Objetivo'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: goals[index]['title'],
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: goals[index]['description'],
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: goals[index]['deadline'],
                decoration: const InputDecoration(labelText: 'Fecha límite'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _deleteGoal(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Objetivo'),
        content: const Text('¿Estás seguro de que deseas eliminar este objetivo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() => goals.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text('Objetivos'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Crear nuevo objetivo')),
                );
              },
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final goal = goals[index];
              return _GoalCard(
                title: goal['title'],
                description: goal['description'],
                progress: goal['progress'],
                icon: goal['icon'],
                color: goal['color'],
                deadline: goal['deadline'],
                onEdit: () => _editGoal(index),
                onDelete: () => _deleteGoal(index),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _GoalCard extends StatelessWidget {
  final String title;
  final String description;
  final double progress;
  final IconData icon;
  final Color color;
  final String deadline;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _GoalCard({
    required this.title,
    required this.description,
    required this.progress,
    required this.icon,
    required this.color,
    required this.deadline,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.lightText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.mutedText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text('Editar'),
                    onTap: onEdit,
                  ),
                  PopupMenuItem(
                    child: const Text(
                      'Eliminar',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: onDelete,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.grey.withValues(alpha: 0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: AppTheme.mutedText),
              const SizedBox(width: 6),
              Text(
                'Fecha límite: $deadline',
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.mutedText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

