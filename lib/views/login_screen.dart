import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapidlegame/models/diamonds_model.dart';
import 'package:tapidlegame/models/user_model.dart';
import 'package:tapidlegame/providers/diamonds_provider.dart';
import 'package:tapidlegame/services/api_service.dart';
import 'package:tapidlegame/views/home_screen.dart';
import 'package:tapidlegame/views/register_screen.dart';
import 'package:tapidlegame/views/upgrades_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Future<Diamonds?> getDiamonds(int? userId) async {
  //   return await ApiService().getDiamondsById(userId);
  // }

  @override
  Widget build(BuildContext context) {
    final diamondsProvider = Provider.of<DiamondsProvider>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Login',
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32.0),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () async {
                  User? a = await ApiService().VerifyLogin(
                      _emailController.text, _passwordController.text);

                  if (a != null) {
                    user = a;
                    stats = await ApiService().getDiamondsById(a.userId);
                    upgrades = await ApiService().getUpgradesById(a.userId);
                    diamondsProvider.update();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MyHomePage(
                              title: 'Tap Idle Game',
                            )));
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 15.0),
                  elevation: 5,
                ),
                child: const Text('Login'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 15.0),
                  elevation: 5,
                ),
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
