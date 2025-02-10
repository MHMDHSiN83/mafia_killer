import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class GuideBoxx extends StatelessWidget {
  const GuideBoxx({super.key, required this.text});

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
    // return AlertDialog(
    //   backgroundColor: Theme.of(context).colorScheme.primary,
    //   elevation: 10,
    //   content: SizedBox(
    //     height: 160,
    //     width: 250,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             MaterialButton(
    //               onPressed: onSave,
    //               color: AppColors.darkgreenColor,
    //               child: Text(
    //                 "ذخیره",
    //                 style: TextStyle(
    //                     color: Theme.of(context).colorScheme.inversePrimary,
    //                     fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //             MaterialButton(
    //               onPressed: onCancel,
    //               color: AppColors.redColor,
    //               child: Text(
    //                 "بازگشت",
    //                 style: TextStyle(
    //                     color: Theme.of(context).colorScheme.inversePrimary,
    //                     fontWeight: FontWeight.bold),
    //               ),
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  double _getTextHeight(BuildContext context, String text) {
    final textStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle,
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: null, // Allow unlimited lines
    );

    // Calculate max width for the text (container width minus horizontal padding)
    final maxWidth = MediaQuery.of(context).size.width -
        100 -
        40; // 100 for left/right positioning, 40 for padding
    textPainter.layout(maxWidth: maxWidth);

    // Return the height of the text plus vertical padding
    return textPainter.size.height + 40; // 40 for top/bottom padding
  }
}

class SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
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

    // Start at the top-left rounded corner
    path.moveTo(radius, 0);
    path.lineTo(radius + tailX, 0);

    // path.lineTo(radius + tailX + tailSize, -tailSize);
    // path.lineTo(radius + tailX + tailSize + tailSize, 0);

    path.lineTo(radius + tailX - 10, -30);
    path.lineTo(radius + tailX + 20, 0);

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
