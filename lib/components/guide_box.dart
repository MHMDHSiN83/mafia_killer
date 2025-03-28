import 'package:flutter/material.dart';

class GuideBox extends StatelessWidget {
  const GuideBox({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 80,
          left: 0,
          right: 0,
          child: AlertDialog.adaptive(
            backgroundColor: Theme.of(context).colorScheme.primary,
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            elevation: 10,
            content: CustomPaint(
              painter: SpeechBubblePainter(),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                width: MediaQuery.of(context).size.width -
                    60, // Adjust width as needed
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    var borderPaint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    var path = Path();

    double radius = 20.0;
    double tailSize = 30.0;
    double tailX = size.width * 0.03;

    path.moveTo(radius, 0);
    path.lineTo(radius + tailX, 0);

    path.lineTo(radius + tailX - 10, -tailSize);
    path.lineTo(radius + tailX + tailSize, 0);

    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - radius, size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);

    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
