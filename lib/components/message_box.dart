import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({super.key, required this.onSave, required this.message});

  final VoidCallback onSave;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 10,
      content: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/dialogbox/DialogBoxBg.png'),
                fit: BoxFit.cover)),
        height: 250,
        width: 650,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(
              flex: 4,
            ),
            Expanded(
              flex: 5,
              child: SizedBox(
                width: 180,
                child: Text(
                  message,
                  style: TextStyle(color: AppColors.brownColor, fontSize: 11),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: MaterialButton(
                onPressed: onSave,
                color: AppColors.brownColor,
                child: Text(
                  "متوجه شدم",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
