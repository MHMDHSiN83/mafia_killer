import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/themes/app_color.dart';

class SixthSenseDialogbox extends StatelessWidget {
  const SixthSenseDialogbox(
      {super.key,
      required this.guessedRight,
      required this.guessedWrong,
      required this.onCancel,
      required this.player});

  final VoidCallback guessedRight;
  final VoidCallback guessedWrong;
  final VoidCallback onCancel;
  final Player player;

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
                  "آیا پدرخوانده نقش ${player.name} (${player.role!.name}) را درست حدس زد؟",
                  style: TextStyle(
                      color: AppColors.brownColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
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
                      onPressed: guessedRight,
                      color: AppColors.brownColor,
                      child: Text(
                        "درست گفت",
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
                      onPressed: guessedWrong,
                      color: AppColors.brownColor,
                      child: Text(
                        "اشتباه گفت",
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
