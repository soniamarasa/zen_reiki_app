import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../../shared/constants/app_assets.dart';
import 'home_store.dart';
import 'widgets/timer_painter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final store = Modular.get<HomeStore>();

  // Controlador para a suavidade do círculo
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _lastProgress = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Inicializa o controlador de animação (300ms de transição suave)
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    store.addListener(_handleStoreChange);
  }

  void _handleStoreChange() {
    if (!mounted) return;

    // Cálculo do progresso atual
    double totalSeconds =
        (store.currentPhase == "Prelude"
                ? store.preludeSeconds
                : store.minutesPerPosition * 60)
            .toDouble();

    double currentProgress = store.remainingSeconds / totalSeconds;

    // Se o progresso mudou, disparamos a animação suave até o novo valor
    if (currentProgress != _lastProgress) {
      _animation = Tween<double>(begin: _lastProgress, end: currentProgress)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          );

      _animationController.forward(from: 0.0);
      _lastProgress = currentProgress;
    }

    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    store.removeListener(_handleStoreChange);
    _animationController.dispose();
    super.dispose();
  }

  // ... (didChangeAppLifecycleState omitido para brevidade, mantenha o seu)

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(AppAssets.backgroundOne, fit: BoxFit.cover),
          ),
          AnimateGradient(
            primaryColors: [
              const Color(0xFFE1F5FE).withValues(alpha: 0.3),
              const Color(0xFFF3E5F5).withValues(alpha: 0.3),
            ],
            secondaryColors: [
              const Color(0xFFB3E5FC).withValues(alpha: 0.4),
              const Color(0xFFE8EAF6).withValues(alpha: 0.4),
            ],
            child: const SizedBox.expand(),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 60 + bottomPadding),
              child: GlassmorphicContainer(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.6,
                borderRadius: 30,
                blur: 20,
                alignment: Alignment.center,
                border: 1.5,
                linearGradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.03),
                    Colors.white.withValues(alpha: 0.01),
                  ],
                ),
                borderGradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.4),
                    Colors.white.withValues(alpha: 0.1),
                  ],
                ),
                child: _buildPlayerContent(),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 30 + bottomPadding,
            child: Center(
              child: Image.asset(
                AppAssets.logo,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          store.currentPhase == "Parado"
              ? "Pronta para começar?"
              : "Posição ${store.currentPosition} de ${store.totalPositions}",
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 40),

        // AQUI ESTÁ A MUDANÇA: AnimatedBuilder para o círculo
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: TimerPainter(
                progress: _animation.value,
              ), // Usa o valor da animação
              child: Container(
                padding: const EdgeInsets.all(60),
                child: Text(
                  _formatTime(store.remainingSeconds),
                  style: const TextStyle(
                    fontSize: 68,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 60),
        _buildControls(),
      ],
    );
  }

  // Refatorei os controles para limpar o build principal
  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (store.currentPhase != "Parado")
          IconButton(
            onPressed: store.resetSession,
            icon: const Icon(
              Icons.refresh_rounded,
              size: 40,
              color: Colors.black38,
            ),
          ),
        const SizedBox(width: 20),
        FloatingActionButton.large(
          backgroundColor: Colors.white.withValues(alpha: 0.4),
          elevation: 0,
          onPressed: store.isRunning ? store.pauseSession : store.startSession,
          child: Icon(
            store.isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
            size: 50,
            color: Colors.blueGrey.shade700,
          ),
        ),
        if (store.currentPhase != "Parado") const SizedBox(width: 60),
      ],
    );
  }

  String _formatTime(int seconds) {
    int mins = seconds ~/ 60;
    int secs = seconds % 60;
    return "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }
}
