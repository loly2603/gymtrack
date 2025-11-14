class User {
  final String id;
  final String email;
  final String name;
  final String role; // 'admin', 'instructor', 'user'

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
  });

  // Convertir a JSON para guardar en SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
    };
  }

  // Crear desde JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? 'user',
    );
  }
}