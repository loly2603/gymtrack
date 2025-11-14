import 'package:gymtrack/models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  User? _currentUser;

  // Usuarios demo para la presentación
  static const List<Map<String, String>> demoUsers = [
    {
      'id': 'admin-001',
      'email': 'admin@gymtrack.com',
      'password': 'admin123',
      'name': 'Admin User',
      'role': 'admin',
    },
    {
      'id': 'instructor-001',
      'email': 'instructor@gymtrack.com',
      'password': 'instructor123',
      'name': 'Instructor User',
      'role': 'instructor',
    },
    {
      'id': 'user-001',
      'email': 'user@gymtrack.com',
      'password': 'user123',
      'name': 'Regular User',
      'role': 'user',
    },
  ];

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  // Obtener usuario actual
  User? get currentUser => _currentUser;

  // Verificar si está autenticado
  bool get isAuthenticated => _currentUser != null;

  // Método de login
  Future<bool> login(String email, String password) async {
    // Simular delay de API
    await Future.delayed(const Duration(milliseconds: 500));

    // Buscar usuario en la lista demo
    try {
      final userMap = demoUsers.firstWhere(
            (user) => user['email'] == email && user['password'] == password,
      );

      _currentUser = User(
        id: userMap['id']!,
        email: userMap['email']!,
        name: userMap['name']!,
        role: userMap['role']!,
      );

      return true;
    } catch (e) {
      _currentUser = null;
      return false;
    }
  }

  // Método de logout
  void logout() {
    _currentUser = null;
  }

  // Obtener usuario por email (útil para pruebas)
  static Map<String, String>? getUserByEmail(String email) {
    try {
      return demoUsers.firstWhere((user) => user['email'] == email);
    } catch (e) {
      return null;
    }
  }
}