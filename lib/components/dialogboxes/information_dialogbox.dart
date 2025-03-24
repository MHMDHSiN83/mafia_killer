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
      backgroundColor: Colors.transparent,
      elevation: 10,
      content: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/dialogbox/DialogBoxBg.png'),
                fit: BoxFit.cover)),
        height: 225,
        width: 650,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 4,
            ),
            Expanded(
                flex: 4,
                child: SizedBox(
                  width: 180,
                  child: Text(
                    text,
                    style: TextStyle(color: AppColors.brownColor),
                  ),
                )),
            Expanded(
              flex: 2,
              child: MaterialButton(
                onPressed: onSave,
                color: AppColors.brownColor,
                child: Text(
                  "متوجه شدم",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Spacer(
              flex: 4,
            )
          ],
        ),
      ),
    );
  }
}
