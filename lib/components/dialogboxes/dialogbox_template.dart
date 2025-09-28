import 'package:flutter/material.dart';
import 'package:mafia_killer/components/my_outlined_button.dart';
import 'package:mafia_killer/themes/app_color.dart';

class DialogboxTemplate extends StatelessWidget {
  const DialogboxTemplate(
      {super.key,
      required this.onSave,
      required this.onCancel,
      required this.firstButtonText,
      this.secondButtonText,
      this.thirdButtonText,
      required this.text});

  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String firstButtonText;
  final String? secondButtonText;
  final String? thirdButtonText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 10,
      content: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/dialogbox/newDialogboxBG.png'),
                fit: BoxFit.cover)),
        height: 180,
        //width: 650,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(
              flex: 4,
            ),
            Expanded(
              flex: 4,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
            Spacer(
              flex: 2,
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
                      onPressed: onSave,
                      color: AppColors.greenColor,
                      child: Text(
                          // minFontSize: 10,
                          // maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                          firstButtonText,
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
