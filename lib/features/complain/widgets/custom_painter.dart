import 'dart:ui';

import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final double inset = 2.0; // Adjust the inset to prevent cutting
  final double cornerRadius = 15.0; // Radius for rounded corners

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path();
    // Create the path with inset to prevent cutting on edges and rounded corners
    path.moveTo(inset + cornerRadius, inset); // Start after the top-left corner

    // Top side with top-right corner
    path.lineTo(size.width - inset - cornerRadius,
        inset); // Line to before top-right corner
    path.quadraticBezierTo(
      size.width - inset, inset, // Control point at the corner
      size.width - inset, inset + cornerRadius, // End point after the corner
    );

    // Right side with bottom-right corner
    path.lineTo(
        size.width - inset,
        size.height -
            inset -
            cornerRadius); // Line to before bottom-right corner
    path.quadraticBezierTo(
      size.width - inset, size.height - inset, // Control point at the corner
      size.width - inset - cornerRadius,
      size.height - inset, // End point after the corner
    );

    // Bottom side with bottom-left corner
    path.lineTo(inset + cornerRadius,
        size.height - inset); // Line to before bottom-left corner
    path.quadraticBezierTo(
      inset, size.height - inset, // Control point at the corner
      inset, size.height - inset - cornerRadius, // End point after the corner
    );

    // Left side with top-left corner
    path.lineTo(inset, inset + cornerRadius); // Line to before top-left corner
    path.quadraticBezierTo(
      inset, inset, // Control point at the corner
      inset + cornerRadius, inset, // End point after the corner
    );

    // Draw dashed line
    final dashPath = Path();
    final dashWidth = 5.0;
    final dashSpace = 5.0;

    for (final PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
