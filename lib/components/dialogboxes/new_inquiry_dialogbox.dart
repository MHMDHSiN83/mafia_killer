import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class NewInquiryDialogbox extends StatelessWidget {
  const NewInquiryDialogbox({super.key, required this.inquiry});

  final String inquiry;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 10,
      content: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                //scale: 0.5,
                image: AssetImage('lib/images/dialogbox/DialogBoxBg.png'),
                fit: BoxFit.cover)),
        height: 240,
        width: 650,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 5,
            ),
            Expanded(
                flex: 4,
                child: SizedBox(
                    width: 195,
                    // child: child,
                    child: Text(
                      inquiry,
                      style: TextStyle(
                        color: AppColors.brownColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ))),
            Expanded(
              flex: 2,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: AppColors.brownColor,
                child: Text(
                  "متوجه شدم",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 11),
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
