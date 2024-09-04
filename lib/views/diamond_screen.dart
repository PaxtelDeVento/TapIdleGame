import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tapidlegame/providers/diamonds_provider.dart';
import 'package:provider/provider.dart';
import 'package:tapidlegame/views/home_screen.dart';

class DiamondsPage extends StatefulWidget {
  const DiamondsPage({super.key});

  @override
  State<DiamondsPage> createState() => _DiamondsPageState();
}

class _DiamondsPageState extends State<DiamondsPage> {
  final formatter = NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    final diamondsProvider = Provider.of<DiamondsProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text('Diamantes de ${user?.username}'),
            Text('${formatter.format(diamondsProvider.diamonds.toInt())} 💎',
                style: const TextStyle(fontSize: 45)),
            Text(
                '${diamondsProvider.diamondsPerSecond.toStringAsFixed(1)} 💎/seg',
                style: const TextStyle(fontSize: 25)),
            Text('${diamondsProvider.diamondsPerTap.toStringAsFixed(1)} 💎/👆',
                style: const TextStyle(fontSize: 25)),
            const SizedBox(height: 20),
            const SizedBox(height: 200),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                diamondsProvider.tap();
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                shadowColor: Colors.black.withOpacity(1),
                elevation: 20,
                side: BorderSide(color: Colors.blue[800]!, width: 3),
              ),
              child: const Column(
                children: [
                  Text(
                    ' 💎 ',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}
