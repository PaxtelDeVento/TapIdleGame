import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapidlegame/models/diamonds_model.dart';
import 'package:tapidlegame/models/user_model.dart';
import 'package:tapidlegame/providers/diamonds_provider.dart';
import 'package:tapidlegame/services/api_service.dart';
import 'package:tapidlegame/views/diamond_screen.dart';
import 'package:tapidlegame/views/settings_screen.dart';
import 'package:tapidlegame/views/upgrades_screen.dart';

Diamonds? stats =
    Diamonds.withoutId(diamonds: 0, diamondsPerTap: 1, diamondsPerSecond: 0);
User? user = User.withoutId(username: '', email: '', password: '');

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final diamondsProvider =
        Provider.of<DiamondsProvider>(context, listen: false);
    if (state == AppLifecycleState.detached) {
      await ApiService().updateDiamonds(Diamonds(
          id: stats?.id,
          userId: stats?.userId,
          diamonds: diamondsProvider.diamonds,
          diamondsPerTap: diamondsProvider.diamondsPerTap,
          diamondsPerSecond: diamondsProvider.diamondsPerSecond));
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    const UpgradesPage(),
    const DiamondsPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.upgrade, color: Colors.blue),
            label: 'Upgrades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.diamond, color: Colors.blue),
            label: 'Diamantes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.blue),
            label: 'Configurações',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
