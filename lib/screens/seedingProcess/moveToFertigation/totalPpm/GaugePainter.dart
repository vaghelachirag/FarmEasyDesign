// ppm_gauge.dart
import 'package:flutter/material.dart';
import 'dart:math';

class GaugePainter extends CustomPainter {
  final int ppmValue;
  GaugePainter(this.ppmValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    // Segments
    paint.color = Colors.green.shade200;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        pi, pi / 3, false, paint);

    paint.color = Colors.green;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        pi + pi / 3, pi / 3, false, paint);

    paint.color = Colors.black;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        pi + 2 * pi / 3, pi / 3, false, paint);

    // Pointer
    final angle = pi + (ppmValue / 1000) * pi;
    final pointerX = center.dx + radius * cos(angle);
    final pointerY = center.dy + radius * sin(angle);

    paint.color = Colors.black;
    paint.strokeWidth = 2;
    canvas.drawLine(center, Offset(pointerX, pointerY), paint);
    canvas.drawCircle(center, 4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
