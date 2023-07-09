import 'package:flutter/material.dart';

// A Hollow cirle to reprsent a point in a pet adoption
// history timeline.
class HollowCirclePainter extends CustomPainter {
  final Color strokeColor;
  final double strokeWidth;

  HollowCirclePainter({this.strokeColor = Colors.blue, this.strokeWidth = 6.0});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3 - strokeWidth / 3;

    final paint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(HollowCirclePainter oldDelegate) => false;
}

class HollowCircleWidget extends StatelessWidget {
  final Color strokeColor;
  const HollowCircleWidget({super.key, this.strokeColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HollowCirclePainter(strokeColor: strokeColor),
      child: Container(),
    );
  }
}
