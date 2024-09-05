import 'package:flutter/material.dart';
import 'package:mafia_killer/components/counterbox.dart';

class RowCounterBox extends StatelessWidget {
  RowCounterBox({
    super.key,
    required this.title,
    required this.increaseNumber,
    required this.decreaseNumber,
    required this.number,
    required this.isTimer,
    required this.varName,
  });
  final String title;
  String number;
  final Function(bool, String) increaseNumber;
  final Function(bool, String) decreaseNumber;
  bool isTimer;
  String varName;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
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
