import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final double height;

  const DashedLine({super.key, this.height = 1.0});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height),
      painter: DashedLinePainter(),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    Path path = Path();

    double dashWidth = 5;
    double dashSpace = 5;

    for (double i = 0; i < size.width; i += dashWidth + dashSpace) {
      path.moveTo(i, size.height / 2);
      path.lineTo(i + dashWidth, size.height / 2);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
