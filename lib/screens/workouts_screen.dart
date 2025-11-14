import 'package:flutter/material.dart';
import 'workout_entry_screen.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  String _selectedFilter = 'Todos';


  final List<Map<String, dynamic>> _workouts = [
    {
      'title': 'Pecho y Tríceps',
      'date': '15 Oct 2025',
      'duration': '45 min',
      'exercises': 8,
      'category': 'Pecho',
    },
    {
      'title': 'Espalda y Bíceps',
      'date': '13 Oct 2025',
      'duration': '50 min',
      'exercises': 9,
      'category': 'Espalda',
    },
    {
      'title': 'Pierna',
      'date': '11 Oct 2025',
      'duration': '60 min',
      'exercises': 10,
      'category': 'Pierna',
    },
    {
      'title': 'Hombro y Abdomen',
      'date': '9 Oct 2025',
      'duration': '40 min',
      'exercises': 7,
      'category': 'Hombro',
    },
    {
      'title': 'Full Body',
      'date': '7 Oct 2025',
      'duration': '55 min',
      'exercises': 12,
      'category': 'Full Body',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrenamientos'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Búsqueda próximamente')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _FilterChip(
                  label: 'Todos',
                  isSelected: _selectedFilter == 'Todos',
                  onTap: () => setState(() => _selectedFilter = 'Todos'),
                ),
                _FilterChip(
                  label: 'Pecho',
                  isSelected: _selectedFilter == 'Pecho',
                  onTap: () => setState(() => _selectedFilter = 'Pecho'),
                ),
                _FilterChip(
                  label: 'Espalda',
                  isSelected: _selectedFilter == 'Espalda',
                  onTap: () => setState(() => _selectedFilter = 'Espalda'),
                ),
                _FilterChip(
                  label: 'Pierna',
                  isSelected: _selectedFilter == 'Pierna',
                  onTap: () => setState(() => _selectedFilter = 'Pierna'),
                ),
                _FilterChip(
                  label: 'Hombro',
                  isSelected: _selectedFilter == 'Hombro',
                  onTap: () => setState(() => _selectedFilter = 'Hombro'),
                ),
                _FilterChip(
                  label: 'Full Body',
                  isSelected: _selectedFilter == 'Full Body',
                  onTap: () => setState(() => _selectedFilter = 'Full Body'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Lista de entrenamientos
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _workouts.length,
              itemBuilder: (context, index) {
                final workout = _workouts[index];
                if (_selectedFilter != 'Todos' &&
                    workout['category'] != _selectedFilter) {
                  return const SizedBox.shrink();
                }
                return _WorkoutCard(
                  title: workout['title'],
                  date: workout['date'],
                  duration: workout['duration'],
                  exercises: workout['exercises'],
                  category: workout['category'],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WorkoutEntryScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuevo'),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: Theme.of(context).colorScheme.primary,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : null,
        ),
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final String title;
  final String date;
  final String duration;
  final int exercises;
  final String category;

  const _WorkoutCard({
    required this.title,
    required this.date,
    required this.duration,
    required this.exercises,
    required this.category,
  });

  IconData _getCategoryIcon() {
    switch (category) {
      case 'Pecho':
        return Icons.fitness_center;
      case 'Espalda':
        return Icons.accessibility_new;
      case 'Pierna':
        return Icons.directions_run;
      case 'Hombro':
        return Icons.sports_handball;
      case 'Full Body':
        return Icons.sports_gymnastics;
      default:
        return Icons.fitness_center;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ver detalles de: $title')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(_getCategoryIcon(), color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.list, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '$exercises ejercicios',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

