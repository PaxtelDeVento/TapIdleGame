// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  int? userId;
  String username;
  String email;
  String password;

  // Construtor
  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
  });

  User.withoutId({
    required this.username,
    required this.email,
    required this.password,
  });

  // Método para criar um objeto User a partir de um Map (como de um banco de dados)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }

  // Método para converter um objeto User em um Map (como para salvar em um banco de dados)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userId: $userId, username: $username, email: $email, password: $password)';
  }
}
