import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:tapidlegame/models/diamonds_model.dart';
import 'package:tapidlegame/models/user_model.dart';
import 'package:tapidlegame/views/home_screen.dart';
import 'package:tapidlegame/views/login_screen.dart';

class ApiService {
  final String baseUrl = 'http://192.168.3.19:5151/api';

  Future<User?> getUser(String email) async {
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

      return response.statusCode == 201;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<Diamonds?> getDiamondsById(int userId) async {
    final url = Uri.parse('$baseUrl/Diamonds/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        stats = Diamonds.fromJson(response.body);
      } else {
        print('Erro ao buscar diamantes: ${response.statusCode}'); 
        return null;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<bool?> VerifyLogin(String email, String senha) async {
    final url = Uri.parse('$baseUrl/User/login');
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'password': senha,
          }));
      if (response.statusCode == 200) {
        user = User.fromJson(response.body);
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
