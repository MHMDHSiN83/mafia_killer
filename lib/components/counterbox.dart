import 'package:flutter/material.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/themes/app_color.dart';

class CounterBox extends StatefulWidget {
  CounterBox({
    super.key,
    required this.increaseNumber,
    required this.decreaseNumber,
    required this.number,
    required this.isTimer,
    required this.varName,
  });
  final Function(bool, String) increaseNumber;
  final Function(bool, String) decreaseNumber;
  bool isTimer;
  String number;
  String varName;

  @override
  State<CounterBox> createState() => _CounterBoxState();
}

class _CounterBoxState extends State<CounterBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => widget.increaseNumber(widget.isTimer, widget.varName),
          child: Icon(
            Icons.keyboard_arrow_right,
            color: AppColors.greenColor,
            size: 40,
          ),
        ),
        Text(
          Language.toPersian(widget.number),
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 30,
          ),
        ),
        GestureDetector(
          onTap: () => widget.decreaseNumber(widget.isTimer, widget.varName),
          child: Icon(
            Icons.keyboard_arrow_left,
            color: AppColors.greenColor,
            size: 40,
          ),
        ),
      ],
    );
  }
}
