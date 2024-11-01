import 'package:flutter/material.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/themes/app_color.dart';

class CounterBox extends StatelessWidget {
  const CounterBox({
    super.key,
    required this.increaseNumber,
    required this.decreaseNumber,
    required this.number,
    required this.isTimer,
    required this.varName,
  });
  final Function(bool, String) increaseNumber;
  final Function(bool, String) decreaseNumber;
  final bool isTimer;
  final int number;
  final String varName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => increaseNumber(isTimer, varName),
          child: const Icon(
            Icons.keyboard_arrow_right,
            color: AppColors.greenColor,
            size: 40,
          ),
        ),
        Text(
          Language.toPersian(isTimer
              ? Language.formatTime(number)
              : (number).toString()),
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 30,
          ),
        ),
        GestureDetector(
          onTap: () => decreaseNumber(isTimer, varName),
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: AppColors.greenColor,
            size: 40,
          ),
        ),
      ],
    );
  }
}
