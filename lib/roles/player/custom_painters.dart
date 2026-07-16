import 'package:flutter/material.dart';
import 'dart:math' as math;

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

    final Paint gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final Paint fillPaint = Paint()
      ..color = const Color(0xFFD4AF37).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = const Color(0xFFD4AF37)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw background grid (concentric polygons)
    for (int i = 1; i <= 5; i++) {
      final r = radius * (i / 5);
      final path = Path();
      for (int j = 0; j < stats.length; j++) {
        final x = centerX + r * math.cos(angleStep * j - math.pi / 2);
        final y = centerY + r * math.sin(angleStep * j - math.pi / 2);
        if (j == 0) path.moveTo(x, y);
        else path.lineTo(x, y);
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // Draw axes
    for (int i = 0; i < stats.length; i++) {
      final x = centerX + radius * math.cos(angleStep * i - math.pi / 2);
      final y = centerY + radius * math.sin(angleStep * i - math.pi / 2);
      canvas.drawLine(Offset(centerX, centerY), Offset(x, y), gridPaint);
      
      // Draw labels
      final labelX = centerX + (radius + 20) * math.cos(angleStep * i - math.pi / 2);
      final labelY = centerY + (radius + 20) * math.sin(angleStep * i - math.pi / 2);
      
      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(labelX - textPainter.width / 2, labelY - textPainter.height / 2));
    }

    // Draw the data polygon
    final dataPath = Path();
    for (int i = 0; i < stats.length; i++) {
      final r = radius * stats[i];
      final x = centerX + r * math.cos(angleStep * i - math.pi / 2);
      final y = centerY + r * math.sin(angleStep * i - math.pi / 2);
      if (i == 0) dataPath.moveTo(x, y);
      else dataPath.lineTo(x, y);
    }
    dataPath.close();
    canvas.drawPath(dataPath, fillPaint);
    canvas.drawPath(dataPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SoccerFieldPainter extends CustomPainter {
  final List<Map<String, dynamic>>? positions;

  SoccerFieldPainter({this.positions});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Paint fillPaint = Paint()..color = Colors.white.withValues(alpha: 0.03);

    // Field boundary
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), fillPaint);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), linePaint);

    // Center circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 20, linePaint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), linePaint);

    // Penalty boxes
    canvas.drawRect(Rect.fromLTWH(size.width * 0.2, 0, size.width * 0.6, size.height * 0.15), linePaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.2, size.height * 0.85, size.width * 0.6, size.height * 0.15), linePaint);
    
    // Draw positions if provided
    if (positions != null) {
      for (var pos in positions!) {
        final isPrimary = pos['primary'] ?? false;
        final double x = size.width * pos['x'];
        final double y = size.height * pos['y'];
        final double radius = isPrimary ? 16 : 12;
        
        // Glow/Shadow effect
        if (isPrimary) {
          final Paint shadowPaint = Paint()
            ..color = const Color(0xFFE91E63).withValues(alpha: 0.3)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
          canvas.drawCircle(Offset(x, y), radius + 4, shadowPaint);
        }

        final Paint posPaint = Paint()
          ..color = isPrimary ? const Color(0xFFE91E63) : Colors.white.withValues(alpha: 0.2)
          ..style = PaintingStyle.fill;
          
        canvas.drawCircle(Offset(x, y), radius, posPaint);
        
        // Draw label inside circle
        final textPainter = TextPainter(
          text: TextSpan(
            text: pos['pos'],
            style: TextStyle(
              color: isPrimary ? Colors.white : Colors.white70,
              fontSize: isPrimary ? 10 : 8,
              fontWeight: FontWeight.w900,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
