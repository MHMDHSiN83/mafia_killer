import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class ConfirmationDialogbox extends StatelessWidget {
  const ConfirmationDialogbox(
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
        //width: 650,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(
              flex: 5,
            ),
            Expanded(
              flex: 4,
              child: Text(
                
                "آیا از انتخاب خود مطمئنید؟",
                style: TextStyle(color: AppColors.brownColor),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 10,
                  ),
                  Expanded(
                    flex: 16,
                    child: MaterialButton(
                      onPressed: onCancel,
                      color: AppColors.brownColor,
                      child: Text(
                        // minFontSize: 10,
                        // maxLines: 1,
                        // overflow: TextOverflow.ellipsis,
                        "خیر",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Expanded(
                    flex: 16,
                    child: MaterialButton(
                      onPressed: onSave,
                      color: AppColors.brownColor,
                      child: Text(
                        // minFontSize: 10,
                        // maxLines: 1,
                        // overflow: TextOverflow.ellipsis,
                        "بله",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 10,
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
