import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class SixthSenseBox extends StatelessWidget {
  const SixthSenseBox(
      {super.key,
      required this.guessedRight,
      required this.guessedWrong,
      required this.onCancel});

  final VoidCallback guessedRight;
  final VoidCallback guessedWrong;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 10,
      content: SizedBox(
        height: 160,
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: guessedRight,
              color: AppColors.darkgreenColor,
              child: Text(
                "درست گفت",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            MaterialButton(
              onPressed: guessedWrong,
              color: AppColors.darkgreenColor,
              child: Text(
                "اشتباه گفت",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            MaterialButton(
              onPressed: onCancel,
              color: AppColors.darkgreenColor,
              child: Text(
                "بازگشت",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
