import 'dart:math';
import 'package:flutter/material.dart';

class TimerPainter extends CustomPainter {
  final double progress; // De 0.0 a 1.0

  TimerPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    // 1. Desenha o rastro (fundo do círculo)
    Paint trackPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawCircle(center, radius, trackPaint);

    // 2. Desenha o progresso (a parte que brilha)
    Paint progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF8DAA91), // Verde Sálvia (das folhas)
          Color(0xFFD4A373),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    // Desenha o arco baseado no tempo restante
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Começa no topo (12 horas)
      2 * pi * progress, // O quanto ele preenche
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
