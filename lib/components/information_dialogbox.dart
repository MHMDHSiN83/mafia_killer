import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class InformationDialogbox extends StatelessWidget {
  const InformationDialogbox(
      {super.key, required this.text, required this.onSave});

  final VoidCallback onSave;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 10,
      content: SizedBox(
        height: 100,
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: Text(text)),
            Expanded(
              flex: 1,
              child: MaterialButton(
                onPressed: onSave,
                color: AppColors.darkgreenColor,
                child: Text(
                  "متوجه شدم",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
