import 'package:flutter/material.dart';
import 'package:tapidlegame/models/diamonds_model.dart';
import 'package:tapidlegame/providers/diamonds_provider.dart';
import 'package:tapidlegame/services/api_service.dart';
import 'package:tapidlegame/views/home_screen.dart';
import 'package:tapidlegame/views/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:tapidlegame/views/upgrades_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    final diamondsProvider = Provider.of<DiamondsProvider>(context);
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text("logado como ${user?.email ?? " "}"),
          ElevatedButton(
              onPressed: () async {
                await ApiService().updateDiamonds(Diamonds(
                    id: stats?.id,
                    userId: stats?.userId,
                    diamonds: diamondsProvider.diamonds,
                    diamondsPerTap: diamondsProvider.diamondsPerTap,
                    diamondsPerSecond: diamondsProvider.diamondsPerSecond));

                await ApiService().updateUpgrades(upgrades, user?.userId);

                diamondsProvider.clearDiamonds();

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text("logout")),
          // ElevatedButton(
          //     onPressed: () {
          //       print(user);
          //     },
          //     child: const Text("print user")),
          // ElevatedButton(
          //     onPressed: () {
          //       print(stats);
          //     },
          //     child: const Text("print diamonds")),
          // ElevatedButton(
          //     onPressed: () {
          //       print("${diamondsProvider.diamonds},${diamondsProvider.diamondsPerSecond},${diamondsProvider.diamondsPerTap}");
          //     },
          //     child: const Text("print provider")),
        ],
      )),
    );
  }
}
