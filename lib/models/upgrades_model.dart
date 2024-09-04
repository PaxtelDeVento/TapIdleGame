// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Upgrades {
  int id;                    // Id do upgrade
  String name;               // Nome do upgrade
  String description;        // Descrição do upgrade
  int cost;                  // Custo do upgrade em diamantes
  int cost_increment;        // Aumento no preço quando é comprado
  int amount;                // Quantidade do upgrade comprado
  String modifier;           // Tipo de modificador do upgrade, fixo ou porcentagem
  double diamonds_increment; // Quantos diamantes o upgrade vai aumentar
  String type;               // Se é diamantes por segundo ou por click


  // Construtor
  Upgrades({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.cost_increment,
    required this.amount,
    required this.modifier,
    required this.diamonds_increment,
    required this.type
  });

  // Método para criar um objeto Upgrade a partir de um Map (como de um banco de dados)
  factory Upgrades.fromMap(Map<String, dynamic> map) {
    return Upgrades(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      cost: map['cost'] as int,
      cost_increment: map['cost_increment'] as int,
      amount: map['amount'] as int,
      modifier: map['modifier'] as String,
      diamonds_increment: (map['diamonds_increment'] as num).toDouble(),
      type: map['type'] as String,
    );
  }

  // Método para converter um objeto Upgrade em um Map (como para salvar em um banco de dados)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'cost': cost,
      'cost_increment': cost_increment,
      'amount': amount,
      'modifier': modifier,
      'diamonds_increment': diamonds_increment,
      'type': type,
    };
  }

  String toJson() => json.encode(toMap());

  factory Upgrades.fromJson(String source) => Upgrades.fromMap(json.decode(source) as Map<String, dynamic>);
}
