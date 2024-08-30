import 'package:flutter/material.dart';
import 'package:tapidlegame/views/login_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});


  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  void logout(){
    setState(() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  void salvar(){

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          ElevatedButton(onPressed: logout, child: const Text("logout")),
          ElevatedButton(onPressed: salvar, child: const Text("salvar")),
        ],
      )),
    );
  }
}