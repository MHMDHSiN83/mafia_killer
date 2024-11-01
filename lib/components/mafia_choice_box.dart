import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class MafiaChoiceBox extends StatelessWidget {
  const MafiaChoiceBox(
      {super.key,
      required this.shot,
      required this.buying,
      required this.sixthSense});

  final VoidCallback shot;
  final VoidCallback buying;
  final VoidCallback sixthSense;

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
              onPressed: shot,
              color: AppColors.darkgreenColor,
              child: Text(
                "شلیک شب",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              onPressed: sixthSense,
              color: AppColors.redColor,
              child: Text(
                "حس ششم",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              onPressed: buying,
              color: AppColors.redColor,
              child: Text(
                "خریداری",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
