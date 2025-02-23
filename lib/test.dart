import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ComicSpeechBubblePage(),
    );
  }
}

class ComicSpeechBubblePage extends StatefulWidget {
  const ComicSpeechBubblePage({super.key});

  @override
  _ComicSpeechBubblePageState createState() => _ComicSpeechBubblePageState();
}

class _ComicSpeechBubblePageState extends State<ComicSpeechBubblePage> {
  bool _showBubble = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comic Speech Bubble')),
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut, // Smooth animation
            top: _showBubble ? 200 : -100, // Start from top, animate to 200px
            left: 50,
            right: 50,
            child: ComicSpeechBubble(
              text: "test test test  testtest testtestvS",
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showBubble = !_showBubble;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ComicSpeechBubble extends StatelessWidget {
  final String text;

  const ComicSpeechBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // Measure text height including padding
    final textHeight = _getTextHeight(context, text);

    return CustomPaint(
      painter: SpeechBubblePainter(),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        width:
            MediaQuery.of(context).size.width - 100, // Adjust width as needed
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
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
    double tailX = size.width * 0.1;

    // Start at the top-left rounded corner
    path.moveTo(radius, 0);
    path.lineTo(radius + tailX, 0);
    path.lineTo(radius + tailX + tailSize, -tailSize);
    path.lineTo(radius + tailX + tailSize + tailSize, 0);
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
