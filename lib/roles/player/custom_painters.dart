import 'dart:math' as math;
import 'package:flutter/material.dart';

class RadarChartPainter extends CustomPainter {
  final List<double> stats;
  final List<String> labels;

  RadarChartPainter({required this.stats, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = math.min(centerX, centerY) * 0.8;
    final angleStep = (2 * math.pi) / stats.length;

    final outlinePaint = Paint()
      ..color = Colors.white10
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final labelStyle = const TextStyle(color: Colors.white38, fontSize: 8);

    for (var i = 1; i <= 4; i++) {
      final r = radius * (i / 4);
      final path = Path();
      for (var j = 0; j < stats.length; j++) {
        final angle = j * angleStep - math.pi / 2;
        final x = centerX + r * math.cos(angle);
        final y = centerY + r * math.sin(angle);
        if (j == 0) path.moveTo(x, y); else path.lineTo(x, y);
      }
      path.close();
      canvas.drawPath(path, outlinePaint);
    }

    for (var j = 0; j < stats.length; j++) {
      final angle = j * angleStep - math.pi / 2;
      canvas.drawLine(
        Offset(centerX, centerY),
        Offset(centerX + radius * math.cos(angle), centerY + radius * math.sin(angle)),
        outlinePaint,
      );
      
      final textPainter = TextPainter(
        text: TextSpan(text: labels[j], style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      final lx = centerX + (radius + 15) * math.cos(angle) - textPainter.width / 2;
      final ly = centerY + (radius + 15) * math.sin(angle) - textPainter.height / 2;
      textPainter.paint(canvas, Offset(lx, ly));
    }

    final dataPaint = Paint()
      ..color = Colors.pinkAccent.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;
      
    final dataOutlinePaint = Paint()
      ..color = Colors.pinkAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final dataPath = Path();
    for (var j = 0; j < stats.length; j++) {
      final angle = j * angleStep - math.pi / 2;
      final r = radius * stats[j];
      final x = centerX + r * math.cos(angle);
      final y = centerY + r * math.sin(angle);
      if (j == 0) dataPath.moveTo(x, y); else dataPath.lineTo(x, y);
    }
    dataPath.close();
    canvas.drawPath(dataPath, dataPaint);
    canvas.drawPath(dataPath, dataOutlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SoccerFieldPainter extends CustomPainter {
  final List<Map<String, dynamic>> positions;

  SoccerFieldPainter({required this.positions});

  @override
  void paint(Canvas canvas, Size size) {
    final fieldPaint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(15)), fieldPaint);


    canvas.drawRRect(RRect.fromRectAndRadius(rect.deflate(5), const Radius.circular(10)), linePaint);
    
    canvas.drawLine(Offset(5, size.height / 2), Offset(size.width - 5, size.height / 2), linePaint);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 25, linePaint);

    canvas.drawRect(Rect.fromLTWH(size.width * 0.25, 5, size.width * 0.5, size.height * 0.18), linePaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.35, 5, size.width * 0.3, size.height * 0.08), linePaint);
    
    canvas.drawRect(Rect.fromLTWH(size.width * 0.25, size.height - 5 - size.height * 0.18, size.width * 0.5, size.height * 0.18), linePaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.35, size.height - 5 - size.height * 0.08, size.width * 0.3, size.height * 0.08), linePaint);

    for (var p in positions) {
      final x = p['x'] * size.width;
      final y = p['y'] * size.height;
      final isPrimary = p['primary'] as bool;

      final circlePaint = Paint()
        ..color = isPrimary ? const Color(0xFFE91E63) : const Color(0xFF4A4A4A)
        ..style = PaintingStyle.fill;
      
      final glowPaint = Paint()
        ..color = isPrimary ? const Color(0xFFE91E63).withValues(alpha: 0.3) : Colors.transparent
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      if (isPrimary) {
        canvas.drawCircle(Offset(x, y), 16, glowPaint);
      }
      
      canvas.drawCircle(Offset(x, y), 14, circlePaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: p['pos'],
          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.5),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
