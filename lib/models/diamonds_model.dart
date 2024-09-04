// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Diamonds {
  int? id;
  int? userId;
  double diamonds; // Quantidade total de diamantes
  double diamondsPerTap; // Quantidade de diamantes ganhos por clique
  double diamondsPerSecond; // Quantidade de diamantes ganhos por segundo

  // Construtor
  Diamonds({
    required this.id,
    required this.userId,
    required this.diamonds,
    required this.diamondsPerTap,
    required this.diamondsPerSecond,
  });

    Diamonds.withoutId({
    required this.diamonds,
    required this.diamondsPerTap,
    required this.diamondsPerSecond,
  });


  // Método para criar o objeto a partir de um Map (do banco de dados)
  factory Diamonds.fromMap(Map<String, dynamic> map) {
    return Diamonds(
      id: map['id']?.toInt() ?? 1,
      userId: map['userId']?.toInt() ?? 1,
      diamonds: map['diamonds']?.toDouble() ?? 0.0,
      diamondsPerTap: map['diamondsPerTap']?.toDouble() ?? 0.1,
      diamondsPerSecond: map['diamondsPerSecond']?.toDouble() ?? 0.2,
    );
  }

  // Método para converter o objeto em um Map (para banco de dados)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'diamonds': diamonds,
      'diamondsPerTap': diamondsPerTap,
      'diamondsPerSecond': diamondsPerSecond,
    };
  }

  @override
  String toString() {
    return 'Diamonds(id: $id, userId: $userId, diamonds: $diamonds, diamondsPerTap: $diamondsPerTap, diamondsPerSecond: $diamondsPerSecond)';
  }

  String toJson() => json.encode(toMap());

  factory Diamonds.fromJson(String source) =>
      Diamonds.fromMap(json.decode(source) as Map<String, dynamic>);
}
