import 'package:flutter/material.dart';

class ConnectorPainter extends CustomPainter {
  final List<bool> readingDays;
  ConnectorPainter(this.readingDays);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF177B4D)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final circleSpacing = size.width / 6; // Assuming 7 circles, 6 gaps

    for (int i = 0; i < readingDays.length - 1; i++) {
      if (readingDays[i] && readingDays[i + 1]) {
        final start = Offset(circleSpacing * i + 25, size.height / 2);
        final end = Offset(circleSpacing * (i + 1) + 25, size.height / 2);
        canvas.drawLine(start, end, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
