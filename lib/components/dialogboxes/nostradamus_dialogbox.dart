import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';

class NostradamusDialogbox extends StatelessWidget {
  const NostradamusDialogbox(
      {super.key, required this.mafiaNumber, required this.chooseSide});

  final int mafiaNumber;
  final void Function(RoleSide) chooseSide;
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
        //width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(
              flex: 5,
            ),
            Expanded(
              flex: 4,
              child: SizedBox(
                width: 180,
                child: Text(
                  'به نوستراداموس عدد ${Language.toPersian(mafiaNumber.toString())} رو نشون بده و ازش بپرس با کدوم ساید می‌خواد بازی کنه',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // MaterialButton(
                  //   onPressed: () {
                  //     AudioManager.playClickEffect();
                  //     Navigator.of(context).pop();
                  //   },
                  //   color: AppColors.brownColor,
                  //   child: Text(
                  //     "بازگشت",
                  //     style: TextStyle(
                  //       color: Theme.of(context).colorScheme.inversePrimary,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  Spacer(
                    flex: 9,
                  ),
                  Expanded(
                    flex: 16,
                    child: MaterialButton(
                      onPressed: () {
                        AudioManager.playClickEffect();
                        chooseSide(RoleSide.mafia);
                      },
                      color: AppColors.brownColor,
                      child: Text(
                        "مافیا",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  if (mafiaNumber !=
                      Player.getPlayersByRoleSide(RoleSide.mafia)!.length - 1)
                    Expanded(
                      flex: 16,
                      child: MaterialButton(
                        onPressed: () {
                          AudioManager.playClickEffect();
                          chooseSide(RoleSide.citizen);
                        },
                        color: AppColors.brownColor,
                        child: Text(
                          "شهروند",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  Spacer(
                    flex: 9,
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
