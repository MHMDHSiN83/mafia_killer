import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_outlinedbutton.dart';


class DialogboxTemplate extends StatelessWidget {
  DialogboxTemplate(
      {super.key,
      required this.firstButtonFunction,
      this.secondButtonFunction,
      this.thirdButtonFunction,
      required this.firstButtonText,
      this.secondButtonText,
      this.thirdButtonText,
      this.firstButtonDisabled,
      this.secondButtonDisabled,
      this.thirdButtonDisabled,
      required this.firstButtonColor,
      this.secondButtonColor,
      this.thirdButtonColor,
      required this.child});

  final VoidCallback firstButtonFunction;
  final VoidCallback? secondButtonFunction;
  final VoidCallback? thirdButtonFunction;
  final String firstButtonText;
  final String? secondButtonText;
  final String? thirdButtonText;
  late bool? firstButtonDisabled = false;
  late bool? secondButtonDisabled = false;
  late bool? thirdButtonDisabled = false;
  final Color firstButtonColor;
  final Color? secondButtonColor;
  final Color? thirdButtonColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 10,
      content: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 15),

        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/dialogbox/newDialogboxBG.png'),
                fit: BoxFit.contain)),
        height: 240,
        //width: 650,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(
              flex: 3,
            ),
            Expanded(
              flex: 5,
              child: Center(child: child),
            ),
            Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: (secondButtonText != null) ? 3 : 10,
                  ),
                  if (secondButtonText != null)
                    Expanded(
                        flex: 16,
                        child: DialogboxOutlinedbutton(
                          text: secondButtonText!,
                          color: (secondButtonDisabled != null &&
                                  secondButtonDisabled!)
                              ? secondButtonColor!.withOpacity(0.5)
                              : secondButtonColor!,
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
                        color: (firstButtonDisabled != null &&
                                firstButtonDisabled!)
                            ? firstButtonColor.withOpacity(0.5)
                            : firstButtonColor,
                        onClick: firstButtonFunction,
                      )),
                  Spacer(
                    flex: (secondButtonText != null) ? 3 : 10,
                  ),
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
                  child: Row(
                    children: [
                      Spacer(
                        flex: 3,
                      ),
                      Expanded(
                        flex: 35,
                        child: DialogboxOutlinedbutton(
                          text: thirdButtonText!,
                          color: (thirdButtonDisabled != null &&
                                  thirdButtonDisabled!)
                              ? thirdButtonColor!.withOpacity(0.5)
                              : thirdButtonColor!,
                          onClick: thirdButtonFunction!,
                        ),
                      ),
                      Spacer(
                        flex: 3,
                      )
                    ],
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
