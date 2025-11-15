import 'package:flutter/material.dart';

class AdminUsersListScreen extends StatefulWidget {
  const AdminUsersListScreen({super.key});

  @override
  State<AdminUsersListScreen> createState() => _AdminUsersListScreenState();
}

class _AdminUsersListScreenState extends State<AdminUsersListScreen> {
  final List<Map<String, dynamic>> users = [
    {
      'id': 1,
      'name': 'Juan Pérez',
      'email': 'juan@example.com',
      'role': 'usuario',
      'joinDate': 'Hace 2 días',
      'isActive': true,
      'trainingSessions': 12,
    },
    {
      'id': 2,
      'name': 'María García',
      'email': 'maria@example.com',
      'role': 'usuario',
      'joinDate': 'Hace 5 días',
      'isActive': true,
      'trainingSessions': 8,
    },
    {
      'id': 3,
      'name': 'Carlos Rodríguez',
      'email': 'carlos@example.com',
      'role': 'entrenador',
      'joinDate': 'Hace 1 semana',
      'isActive': false,
      'trainingSessions': 0,
    },
    {
      'id': 4,
      'name': 'Ana López',
      'email': 'ana@example.com',
      'role': 'usuario',
      'joinDate': 'Hace 3 días',
      'isActive': true,
      'trainingSessions': 15,
    },
    {
      'id': 5,
      'name': 'Jorge Martínez',
      'email': 'jorge@example.com',
      'role': 'usuario',
      'joinDate': 'Hace 1 semana',
      'isActive': true,
      'trainingSessions': 10,
    },
  ];

  void _deleteUser(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Usuario'),
        content: const Text('¿Estás seguro de que deseas eliminar este usuario?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() => users.removeWhere((u) => u['id'] == id));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Usuario eliminado')),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editUser(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Usuario'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: user['name'],
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: user['email'],
                decoration: const InputDecoration(labelText: 'Correo'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: user['role'],
                items: const [
                  DropdownMenuItem(value: 'usuario', child: Text('Usuario')),
                  DropdownMenuItem(value: 'entrenador', child: Text('Entrenador')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                ],
                onChanged: (value) {},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Usuarios'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: user['isActive'] ? Colors.green : Colors.grey,
                child: Text(
                  user['name'][0].toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                user['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(user['email'], style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(
                    '${user['role'].toUpperCase()} • ${user['trainingSessions']} entrenamientos',
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text('Editar'),
                    onTap: () => _editUser(user),
                  ),
                  PopupMenuItem(
                    child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                    onTap: () => _deleteUser(user['id']),
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

