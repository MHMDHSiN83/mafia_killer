import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/pages/intro_night_page.dart';
import 'package:mafia_killer/pages/intro_page.dart';
import 'package:mafia_killer/themes/app_color.dart';

class NostradamusBox extends StatelessWidget {
  const NostradamusBox(
      {super.key, required this.mafiaNumber, required this.chooseSide});

  final int mafiaNumber;
  final void Function(RoleSide) chooseSide;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 10,
      content: SizedBox(
        height: 160,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
                'به نوستراداموس عدد$mafiaNumberنشان بده و ازش بپرس با کدوم ساید می‌خواد بازی کنه'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: AppColors.darkgreenColor,
                  child: Text(
                    "بازگشت",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    chooseSide(RoleSide.mafia);
                  },
                  color: AppColors.darkgreenColor,
                  child: Text(
                    "مافیا",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (mafiaNumber !=
                    2) //TODO build a function to generate max mafia team number
                  MaterialButton(
                    onPressed: () {
                      chooseSide(RoleSide.citizen);
                    },
                    color: AppColors.darkgreenColor,
                    child: Text(
                      "شهروند",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
