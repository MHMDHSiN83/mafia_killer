import 'package:flutter/material.dart';
import 'package:mafia_killer/models/language.dart';

class CounterBox extends StatefulWidget {
  CounterBox({
    super.key,
    required this.increaseNumber,
    required this.decreaseNumber,
    required this.number,
  });
  final Function() increaseNumber;
  final Function() decreaseNumber;
  String number;

  @override
  State<CounterBox> createState() => _CounterBoxState();
}

class _CounterBoxState extends State<CounterBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: widget.increaseNumber,
          child: Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xFF07FFB5),
            size: 40,
          ),
        ),
        Text(
          Language.toPersian(widget.number),
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        GestureDetector(
          onTap: widget.decreaseNumber,
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Color(0xFF07FFB5),
            size: 40,
          ),
        ),
      ],
    );
  }
}
