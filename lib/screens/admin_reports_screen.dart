import 'package:flutter/material.dart';

class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({super.key});

  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> {
  String _selectedPeriod = 'mes';

  final List<Map<String, dynamic>> reports = [
    {
      'title': 'Usuarios Activos',
      'value': '245',
      'change': '+12%',
      'icon': Icons.people,
      'color': Colors.blueAccent,
    },
    {
      'title': 'Entrenamientos',
      'value': '1,240',
      'change': '+8%',
      'icon': Icons.fitness_center,
      'color': Colors.orangeAccent,
    },
    {
      'title': 'Ingresos',
      'value': '\$12,500',
      'change': '+25%',
      'icon': Icons.attach_money,
      'color': Colors.greenAccent,
    },
    {
      'title': 'Ocupación Promedio',
      'value': '82%',
      'change': '+5%',
      'icon': Icons.trending_up,
      'color': Colors.purpleAccent,
    },
  ];

  final List<Map<String, dynamic>> detailedReports = [
    {
      'name': 'Entrenamientos por Tipo',
      'pecho': 145,
      'espalda': 128,
      'pierna': 152,
      'cardio': 98,
      'fullbody': 85,
    },
    {
      'name': 'Horas Pico',
      'morning': 180,
      'afternoon': 220,
      'evening': 160,
    },
    {
      'name': 'Entrenadores Top',
      'carlos': 85,
      'ana': 92,
      'juan': 68,
    },
  ];

  void _exportReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exportar Reporte'),
        content: const Text('¿Deseas exportar este reporte en PDF?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reporte exportado exitosamente'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Exportar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportReport,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _PeriodButton(
                    label: 'Semana',
                    value: 'semana',
                    isSelected: _selectedPeriod == 'semana',
                    onTap: () => setState(() => _selectedPeriod = 'semana'),
                  ),
                  const SizedBox(width: 8),
                  _PeriodButton(
                    label: 'Mes',
                    value: 'mes',
                    isSelected: _selectedPeriod == 'mes',
                    onTap: () => setState(() => _selectedPeriod = 'mes'),
                  ),
                  const SizedBox(width: 8),
                  _PeriodButton(
                    label: 'Trimestre',
                    value: 'trimestre',
                    isSelected: _selectedPeriod == 'trimestre',
                    onTap: () => setState(() => _selectedPeriod = 'trimestre'),
                  ),
                  const SizedBox(width: 8),
                  _PeriodButton(
                    label: 'Año',
                    value: 'ano',
                    isSelected: _selectedPeriod == 'ano',
                    onTap: () => setState(() => _selectedPeriod = 'ano'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Key Metrics
            const Text(
              'Métricas Principales',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.5,
              children: reports.map((report) {
                return _MetricCard(
                  title: report['title'],
                  value: report['value'],
                  change: report['change'],
                  icon: report['icon'],
                  color: report['color'],
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Detailed Reports
            const Text(
              'Reportes Detallados',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _DetailedReportCard(
              title: 'Entrenamientos por Tipo',
              data: [
                ('Pecho', 145),
                ('Espalda', 128),
                ('Pierna', 152),
                ('Cardio', 98),
                ('Full Body', 85),
              ],
            ),
            const SizedBox(height: 12),
            _DetailedReportCard(
              title: 'Horas Pico',
              data: [
                ('Mañana (6-10am)', 180),
                ('Tarde (2-6pm)', 220),
                ('Noche (6-9pm)', 160),
              ],
            ),
            const SizedBox(height: 12),
            _DetailedReportCard(
              title: 'Entrenadores Top',
              data: [
                ('Ana López', 92),
                ('Carlos Rodríguez', 85),
                ('Juan García', 68),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _PeriodButton extends StatelessWidget {
  final String label;
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  const _PeriodButton({
    required this.label,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: Colors.transparent,
      side: BorderSide(
        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = change.startsWith('+');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 28),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                change,
                style: TextStyle(
                  fontSize: 11,
                  color: isPositive ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailedReportCard extends StatelessWidget {
  final String title;
  final List<(String, int)> data;

  const _DetailedReportCard({
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = data.map((e) => e.$2).reduce((a, b) => a > b ? a : b).toDouble();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...data.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final percentage = (item.$2 / maxValue) * 100;

              return Padding(
                padding: EdgeInsets.only(bottom: index < data.length - 1 ? 12 : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.$1,
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          '${item.$2}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: percentage / 100,
                        minHeight: 6,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(
                            255,
                            (255 * (1 - percentage / 100)).toInt(),
                            (255 * (percentage / 100)).toInt(),
                            100,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

