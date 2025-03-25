import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mafia_killer/components/counterbox.dart';

class RowCounterBox extends StatelessWidget {
  const RowCounterBox({
    super.key,
    required this.title,
    required this.increaseNumber,
    required this.decreaseNumber,
    required this.number,
    required this.isTimer,
    required this.varName,
    this.fontSize,
  });

  final double? fontSize;

  final String title;
  final int number;
  final Function(bool, String) increaseNumber;
  final Function(bool, String) decreaseNumber;
  final bool isTimer;
  final String varName;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          minFontSize: 10,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        CounterBox(
          increaseNumber: increaseNumber,
          decreaseNumber: decreaseNumber,
          number: number,
          isTimer: isTimer,
          varName: varName,
        ),
      ],
    );
  }
}
