import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({super.key, required this.onSave, required this.message});

  final VoidCallback onSave;
  final String message;

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
            Text(message),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: onSave,
                  color: AppColors.darkgreenColor,
                  child: Text(
                    "متوجه شدم",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
