import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tapidlegame/models/diamonds_model.dart';
import 'package:tapidlegame/models/upgrades_model.dart';
import 'package:tapidlegame/models/user_model.dart';

class ApiService {
  final String baseUrl = 'http://192.168.3.19:5151/api';

  Future<User?> getUserByEmail(String email) async {
    final url = Uri.parse('$baseUrl/User/$email');
    final response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        return User.fromJson(response.body);
      } else {
        print('Erro ao buscar usuário: ${response.statusCode}');
        return null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> createUser(
      String username, String email, String password) async {
    final url = Uri.parse('$baseUrl/User');
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'username': username,
            'email': email,
            'password': password,
          }));

      return response.statusCode == 201;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> createDiamond(int? userId) async {
    final url = Uri.parse('$baseUrl/Diamonds');
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'userId': userId,
            'diamonds': 0,
            'diamondsPerTap': 1,
            'diamondsPerSecond': 0,
          }));

      return response.statusCode == 200;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<Diamonds?> getDiamondsById(int? userId) async {
    final url = Uri.parse('$baseUrl/Diamonds/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return Diamonds.fromJson(response.body);
      } else {
        print('Erro ao buscar diamantes: ${response.statusCode}');
        return null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> VerifyLogin(String email, String senha) async {
    final url = Uri.parse('$baseUrl/User/login');
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'password': senha,
          }));
      if (response.statusCode == 200) {
        return User.fromJson(response.body);
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> updateDiamonds(Diamonds diamonds) async {
    final url = Uri.parse('$baseUrl/Diamonds');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': diamonds.id,
        'userId': diamonds.userId,
        'diamonds': diamonds.diamonds,
        'diamondsPerTap': diamonds.diamondsPerTap,
        'diamondsPerSecond': diamonds.diamondsPerSecond,
      }),
    );

    if (response.statusCode == 200) {
      print('Diamantes atualizados com sucesso!');
    } else {
      print('Erro ao atualizar diamantes: ${response.statusCode}');
    }
  }

  Future<List<Upgrades>?> getUpgradesById(int? userId) async {
    final url = Uri.parse('$baseUrl/Upgrades/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> a = json.decode(response.body);
      return a.map((element) => Upgrades.fromMap(element)).toList();
    } else {
      return null;
    }
  }

  Future<void> updateUpgrades(List<Upgrades?>? upgrades, int? userId) async {
    final url = Uri.parse('$baseUrl/Upgrades/$userId');

    List<Map<String, dynamic>?> upgradesJson =
        upgrades!.map((upgrade) => upgrade?.toMap()).toList();

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(upgradesJson),
    );

    if (response.statusCode == 200) {
      print('Upgrades atualizados com sucesso!');
    } else {
      print('Erro ao atualizar upgrades: ${response.statusCode}');
    }
  }
}
