import 'package:flutter/material.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/themes/app_color.dart';

class BomberCounterbox extends StatelessWidget {
  const BomberCounterbox({
    super.key,
    required this.increaseNumber,
    required this.decreaseNumber,
    required this.number,
  });
  final VoidCallback increaseNumber;
  final VoidCallback decreaseNumber;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: Material(
            color: AppColors.darkgreenColor, // Button color
            child: InkWell(
              splashColor: AppColors.hoverGreenColor, // Splash color
              onTap: () => increaseNumber(),
              child: const SizedBox(
                width: 28,
                height: 28,
                child: Icon(
                  Icons.add,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          Language.toPersian(number.toString()),
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        ClipOval(
          child: Material(
            color: AppColors.redColor, // Button color
            child: InkWell(
              splashColor: AppColors.hoverRedColor, // Splash color
              onTap: () => decreaseNumber(),
              child: const SizedBox(
                width: 28,
                height: 28,
                child: Icon(
                  Icons.remove,
                  size: 28,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
