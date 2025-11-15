import 'package:flutter/material.dart';

class AdminScheduleScreen extends StatefulWidget {
  const AdminScheduleScreen({super.key});

  @override
  State<AdminScheduleScreen> createState() => _AdminScheduleScreenState();
}

class _AdminScheduleScreenState extends State<AdminScheduleScreen> {
  final List<Map<String, dynamic>> schedules = [
    {
      'id': 1,
      'trainer': 'Carlos Rodríguez',
      'day': 'Lunes',
      'startTime': '06:00',
      'endTime': '07:00',
      'capacity': 15,
      'enrolled': 12,
      'type': 'Pecho y Tríceps',
    },
    {
      'id': 2,
      'trainer': 'Ana López',
      'day': 'Martes',
      'startTime': '07:00',
      'endTime': '08:00',
      'capacity': 20,
      'enrolled': 18,
      'type': 'Espalda y Bíceps',
    },
    {
      'id': 3,
      'trainer': 'Carlos Rodríguez',
      'day': 'Miércoles',
      'startTime': '06:00',
      'endTime': '07:00',
      'capacity': 15,
      'enrolled': 10,
      'type': 'Pierna',
    },
    {
      'id': 4,
      'trainer': 'Juan García',
      'day': 'Jueves',
      'startTime': '07:30',
      'endTime': '08:30',
      'capacity': 20,
      'enrolled': 15,
      'type': 'Cardio',
    },
    {
      'id': 5,
      'trainer': 'Ana López',
      'day': 'Viernes',
      'startTime': '06:00',
      'endTime': '07:00',
      'capacity': 15,
      'enrolled': 14,
      'type': 'Full Body',
    },
  ];

  void _addSchedule() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar Horario'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Entrenador'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Día'),
                items: const [
                  DropdownMenuItem(value: 'Lunes', child: Text('Lunes')),
                  DropdownMenuItem(value: 'Martes', child: Text('Martes')),
                  DropdownMenuItem(value: 'Miércoles', child: Text('Miércoles')),
                  DropdownMenuItem(value: 'Jueves', child: Text('Jueves')),
                  DropdownMenuItem(value: 'Viernes', child: Text('Viernes')),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Hora Inicio (HH:MM)'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Hora Fin (HH:MM)'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Capacidad'),
                keyboardType: TextInputType.number,
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
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  void _deleteSchedule(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Horario'),
        content: const Text('¿Estás seguro de que deseas eliminar este horario?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() => schedules.removeWhere((s) => s['id'] == id));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Horario eliminado')),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Horarios'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: _addSchedule,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          final utilization = (schedule['enrolled'] / schedule['capacity'] * 100).toStringAsFixed(0);

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              schedule['type'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${schedule['day']} • ${schedule['startTime']} - ${schedule['endTime']}',
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                            onTap: () => _deleteSchedule(schedule['id']),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Text(
                        schedule['trainer'],
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Capacidad',
                              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                            ),
                            Text(
                              '${schedule['enrolled']}/${schedule['capacity']}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: schedule['enrolled'] / schedule['capacity'],
                            minHeight: 6,
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              double.parse(utilization) > 80 ? Colors.orange : Colors.green,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$utilization%',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

