import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tapidlegame/views/home_screen.dart';

// Supondo que você tenha um objeto globalDiamonds para gerenciar os dados dos diamantes
// Importe seu serviço API

class DiamondsProvider with ChangeNotifier {
  double _diamonds = 0;
  double _diamondsPerSecond = 0;
  double _diamondsPerTap = 0;
  Timer? _timer;

  DiamondsProvider() {
    _initializeDiamonds();
  }

  double get diamonds => _diamonds;
  double get diamondsPerSecond => _diamondsPerSecond;
  double get diamondsPerTap => _diamondsPerTap;

  // Inicializa os dados de diamantes utilizando o fetch da API
  Future<void> _initializeDiamonds() async {
    if (stats != null) {
      _diamonds = stats!.diamonds;
      _diamondsPerSecond = stats!.diamondsPerSecond;
      _diamondsPerTap = stats!.diamondsPerTap;
    }

    _startAutoDiamondsIncrement();
    notifyListeners();
  }

  void _startAutoDiamondsIncrement() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _diamonds += _diamondsPerSecond;
      notifyListeners();
    });
  }

  void tap() {
    _diamonds += _diamondsPerTap;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void incrementDiamonds(double amount) {
    _diamonds += amount;
    notifyListeners();
  }

  void decrementDiamonds(double amount) {
    _diamonds -= amount;
    notifyListeners();
  }

  void increaseDiamondsPerTap(double amount) {
    _diamondsPerTap += amount;
    notifyListeners();
  }

  void increaseDiamondsPerSecond(double amount) {
    _diamondsPerSecond += amount;
    notifyListeners();
  }

  void clearDiamonds() {
    _diamondsPerSecond = 0;
    _diamondsPerTap = 1;
    _diamonds = 0;
    notifyListeners();
  }

  void update() {
    _diamonds = stats!.diamonds;
    _diamondsPerSecond = stats!.diamondsPerSecond;
    _diamondsPerTap = stats!.diamondsPerTap;
    notifyListeners();
  }
}
