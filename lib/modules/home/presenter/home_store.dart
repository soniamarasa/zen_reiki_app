import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/constants/app_assets.dart';
import '../../../shared/services/just_audio.dart';

class HomeStore extends ChangeNotifier {
  final AudioService _audioService = Modular.get<AudioService>();

  int totalPositions = 15;
  int minutesPerPosition = 1;
  int preludeSeconds = 5;

  int currentPosition = 1;
  int remainingSeconds = 0;
  bool isRunning = false;
  bool isPaused = false;
  String currentPhase = "Parado";

  Timer? _timer;

  void startSession() {
    if (currentPhase == "Parado") {
      currentPhase = "Prelude";
      remainingSeconds = preludeSeconds;

      // AJUSTE: Já deixamos o sino carregado na memória para o play ser instantâneo
      _audioService.preloadBell(AppAssets.bells[0]);
    } else {
      // Se estava apenas pausado, retoma a música de onde parou
      _audioService.resumeMusic();
    }

    isRunning = true;
    isPaused = false;
    notifyListeners();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 1) {
        remainingSeconds--;
        notifyListeners();
      } else {
        // AJUSTE: Quando chega em 1s, o próximo passo já é o zero e a transição
        remainingSeconds = 0;
        notifyListeners();
        _handlePhaseTransition();
      }
    });
  }

  void _handlePhaseTransition() {
    if (currentPhase == "Prelude") {
      // O PRELUDE ACABOU: HORA DE COMEÇAR O REIKI
      currentPhase = "Reiki";
      remainingSeconds = minutesPerPosition * 60;

      // 1. Toca o sino (agora instantâneo por causa do preload)
      _audioService.playBell(AppAssets.bells[0]);

      // 2. Inicia a música de fundo com um pequeno delay para o sino respirar
      Future.delayed(const Duration(milliseconds: 300), () {
        _audioService.playBackgroundMusic(AppAssets.backgroundMusics[0]);
      });
    } else if (currentPhase == "Reiki") {
      if (currentPosition < totalPositions) {
        // TROCA DE POSIÇÃO
        currentPosition++;
        remainingSeconds = minutesPerPosition * 60;

        // 3. Toca o sino para avisar a troca
        _audioService.playBell(AppAssets.bells[0]);
      } else {
        // FIM DE TODAS AS POSIÇÕES
        resetSession();
      }
    }
    notifyListeners();
  }

  void pauseSession() {
    _timer?.cancel();
    isRunning = false;
    isPaused = true;
    _audioService.pauseMusic();
    notifyListeners();
  }

  void resetSession() {
    _timer?.cancel();
    _audioService.stopAll();

    isRunning = false;
    isPaused = false;
    currentPosition = 1;
    remainingSeconds = 0;
    currentPhase = "Parado";

    notifyListeners();
  }
}
