import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_outlinedbutton.dart';
import 'package:mafia_killer/components/my_outlined_button.dart';
import 'package:mafia_killer/themes/app_color.dart';

class DialogboxTemplate extends StatelessWidget {
  const DialogboxTemplate(
      {super.key,
      required this.firstButtonFunction,
      this.secondButtonFunction,
      this.thirdButtonFunction,
      required this.firstButtonText,
      this.secondButtonText,
      this.thirdButtonText,
      required this.child});

  final VoidCallback firstButtonFunction;
  final VoidCallback? secondButtonFunction;
  final VoidCallback? thirdButtonFunction;
  final String firstButtonText;
  final String? secondButtonText;
  final String? thirdButtonText;
  final Widget child;

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
              child: child,
            ),
            Spacer(
              flex: 3,
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: secondButtonText != null ? 5 : 10,
                  ),
                  if (secondButtonText != null)
                    Expanded(
                        flex: 16,
                        child: DialogboxOutlinedbutton(
                          text: secondButtonText!,
                          color: AppColors.redColor,
                          onClick: secondButtonFunction!,
                        )),
                  if (secondButtonText != null)
                    Spacer(
                      flex: 3,
                    ),
                  Expanded(
                      flex: 16,
                      child: DialogboxOutlinedbutton(
                        text: firstButtonText,
                        color: AppColors.darkgreenColor,
                        onClick: firstButtonFunction,
                      )),
                  Spacer(
                    flex: secondButtonText != null ? 5 : 10,
                  )
                ],
              ),
            ),
            if (thirdButtonText != null)
              Spacer(
                flex: 1,
              ),
            if (thirdButtonText != null)
              Expanded(
                  flex: 3,
                  child: DialogboxOutlinedbutton(
                    text: thirdButtonText!,
                    color: AppColors.darkgreenColor,
                    onClick: thirdButtonFunction!,
                  )),
            Spacer(
              flex: 5,
            )
          ],
        ),
      ),
    );
  }
}
