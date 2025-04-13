import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class UpdateDialogbox extends StatelessWidget {
  const UpdateDialogbox(
      {super.key, required this.onSave, required this.onCancel});

  final VoidCallback onSave;
  final VoidCallback onCancel;

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
        height: 240,
        // width: 650,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(
              flex: 5,
            ),
            Expanded(
              flex: 6,
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Text(
                  "یه نسخه جدید از بازی منتشر شده!\nحتما به‌روز رسانی کن تا بهترین تجربه رو از بازی داشته باشی!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.brownColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 8,
                  ),
                  Expanded(
                    flex: 12,
                    child: MaterialButton(
                      onPressed: onCancel,
                      color: AppColors.brownColor,
                      child: Text(
                        "بعدا",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Expanded(
                    flex: 16,
                    child: MaterialButton(
                      onPressed: onSave,
                      color: AppColors.brownColor,
                      child: Text(
                        "به‌روز رسانی",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 8,
                  )
                ],
              ),
            ),
            Spacer(
              flex: 5,
            )
          ],
        ),
      ),
    );
  }
}
