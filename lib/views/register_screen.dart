import 'package:flutter/material.dart';
import 'package:tapidlegame/models/diamonds_model.dart';
import 'package:tapidlegame/models/user_model.dart';
import 'package:tapidlegame/services/api_service.dart';
import 'package:tapidlegame/views/home_screen.dart';
import 'package:tapidlegame/views/login_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Future<void> createUser() async {
  //   await ApiService().createUser(
  //       _nameController.text, _emailController.text, _passwordController.text);
  // }

  Future<void> createDiamond(int? userId) async {
    await ApiService().createDiamond(userId);
  }

  Future<User?> getUser() async {
    return await ApiService().getUserByEmail(_emailController.text);
  }

  Future<Diamonds?> getDiamonds(int? userId) async {
    return await ApiService().getDiamondsById(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Registrar',
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32.0),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16.0),
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
              const SizedBox(height: 16.0),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isConfirmPasswordVisible,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () async {
                  // if (!isValidPassword(_passwordController.text)) {
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) => AlertDialog(
                  //       title: const Text('Erro'),
                  //       content: const Text(
                  //           'A senha deve ter 8 ou mais dígitos, ao menos 1 letra maiúscula e 1 número'),
                  //       actions: <Widget>[
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //           },
                  //           child: const Text('OK'),
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  //   return;
                  // }
                  if (_passwordController.text ==
                      _confirmPasswordController.text) {
                    await ApiService().createUser(_nameController.text,
                        _emailController.text, _passwordController.text);

                    User? a = await ApiService()
                        .getUserByEmail(_emailController.text);

                    createDiamond(a!.userId);

                    stats = await getDiamonds(user!.userId);

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                        title: 'Tap Idle Game',
                      ),
                    ));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Erro'),
                        content: const Text('As senhas não coincidem'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100.0, vertical: 15.0),
                  elevation: 5,
                ),
                child: const Text('Registrar'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 15.0),
                  elevation: 5,
                ),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isValidPassword(String password) {
  if (password.length < 8) {
    return false;
  }

  bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(RegExp(r'[0-9]'));

  return hasUpperCase && hasDigits;
}
