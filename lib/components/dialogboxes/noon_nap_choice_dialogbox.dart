import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class NoonNapChoiceDialogbox extends StatelessWidget {
  const NoonNapChoiceDialogbox(
      {super.key,
      required this.nothing,
      required this.killPlayer,
      required this.veto});

  final VoidCallback nothing;
  final VoidCallback killPlayer;
  final VoidCallback veto;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 10,
      content: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/dialogbox/DialogBoxBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        height: 240,
        width: 650,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(
              flex: 5,
            ),
            Expanded(
              flex: 6,
              child: SizedBox(
                width: 180,
                child: Text(
                  "شهردار بیدار شه و انتخاب کنه که آیا می‌خواد رای گیری رو ملغی کنه یا کس دیگه‌ای رو بیرون بندازه",
                  style: TextStyle(color: AppColors.brownColor, fontSize: 12),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Spacer(
                    flex: 10,
                  ),
                  Expanded(
                    flex: 16,
                    child: MaterialButton(
                      onPressed: veto,
                      color: AppColors.brownColor,
                      child: Text(
                        "ملغی کردن",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 16,
                    child: MaterialButton(
                      onPressed: killPlayer,
                      color: AppColors.brownColor,
                      child: Text(
                        "تعیین کشته",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 10,
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 2,
              child: MaterialButton(
                onPressed: nothing,
                color: AppColors.brownColor,
                child: Text(
                  "هیچ‌کدام",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
