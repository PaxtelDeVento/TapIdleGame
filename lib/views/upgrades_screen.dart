import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tapidlegame/providers/diamonds_provider.dart';
import 'package:tapidlegame/models/upgrades_model.dart';
import 'package:provider/provider.dart';

List<Upgrades?>? upgrades = [];

class UpgradesPage extends StatefulWidget {
  const UpgradesPage({super.key});

  @override
  State<UpgradesPage> createState() => _UpgradesPageState();
}

class _UpgradesPageState extends State<UpgradesPage> {
  final formatter = NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    final diamondsProvider = Provider.of<DiamondsProvider>(context);
    return Column(
      children: [
        Text('${formatter.format(diamondsProvider.diamonds.toInt())} 💎',
            style: const TextStyle(fontSize: 25)),
            Text(
                '${diamondsProvider.diamondsPerSecond.toStringAsFixed(1)} 💎/seg',
                style: const TextStyle(fontSize: 15)),
            Text('${diamondsProvider.diamondsPerTap.toStringAsFixed(1)} 💎/👆',
                style: const TextStyle(fontSize: 15)),
        ListView.builder(
          shrinkWrap: true,
          itemCount: upgrades?.length,
          itemBuilder: (context, index) {
            final upgrade = upgrades?[index];
            return Card(
              color: Colors.grey[400],
              elevation: 20,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(
                  '(${upgrade?.amount}) ${upgrade?.name} ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
                subtitle: Text(
                  upgrade!.description,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${upgrade.cost} 💎',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: diamondsProvider.diamonds < upgrade!.cost
                              ? Colors.red
                              : const Color.fromARGB(255, 114, 255, 119),
                          fontSize: 20),
                    ),
                  ],
                ),
                onTap: () {
                  if (diamondsProvider.diamonds >= upgrade.cost) {
                    if (upgrade.modifier == "DPS") {
                      if (upgrade.type == '%') {
                        diamondsProvider.increaseDiamondsPerSecond(
                            diamondsProvider.diamondsPerSecond *
                                upgrade.diamonds_increment/100);
                      } else {
                        diamondsProvider.increaseDiamondsPerSecond(
                            upgrade.diamonds_increment);
                      }
                    }
                    if (upgrade.modifier  == "DPC") {
                      if (upgrade.type == '%') {
                        diamondsProvider.increaseDiamondsPerTap(
                            diamondsProvider.diamondsPerTap *
                                upgrade.diamonds_increment/100);
                      } else {
                        diamondsProvider
                            .increaseDiamondsPerTap(upgrade.diamonds_increment);
                      }
                    }
                    diamondsProvider.decrementDiamonds(upgrade.cost.toDouble());
                    upgrade.cost += upgrade.cost_increment;
                    upgrade.amount++;
                    //print(stats);
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
