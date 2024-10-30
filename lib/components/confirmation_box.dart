import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class ConfirmationBox extends StatelessWidget {
  ConfirmationBox({super.key, required this.onSave, required this.onCancel});

  VoidCallback onSave;
  VoidCallback onCancel;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: onSave,
                      color: AppColors.darkgreenColor,
                      child: Text(
                        "ذخیره",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    MaterialButton(
                      onPressed: onCancel,
                      color: AppColors.redColor,
                      child: Text(
                        "بازگشت",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
