import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class DieHardDialogbox extends StatelessWidget {
  const DieHardDialogbox({
    super.key,
    required this.takeInquiry,
    required this.notTakeInquiry,
  });

  final VoidCallback takeInquiry;
  final VoidCallback notTakeInquiry;

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
        width: 700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(
              flex: 4,
            ),
            Expanded(
              flex: 4,
              child: SizedBox(
                width: 180,
                child: Text(
                  "جان‌سخت بیدار شه و بگه که استعلام می‌گیره یا نه",
                  style: TextStyle(
                    color: AppColors.brownColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
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
                      onPressed: takeInquiry,
                      color: AppColors.brownColor,
                      child: Text(
                        "می‌گیره",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
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
                      onPressed: notTakeInquiry,
                      color: AppColors.brownColor,
                      child: Text(
                        "نمی‌گیره",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
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
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
