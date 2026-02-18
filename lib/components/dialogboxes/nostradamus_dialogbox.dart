import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
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
    return DialogboxTemplate(
      firstButtonFunction: () {
        AudioManager.playClickEffect();
        chooseSide(RoleSide.mafia);
      },
      firstButtonText: "مافیا",
      firstButtonColor: AppColors.redColor,
      secondButtonText: (mafiaNumber !=
              Player.getPlayersByRoleSide(RoleSide.mafia)!.length - 1)
          ? "شهروند"
          : null,
      secondButtonColor: AppColors.darkgreenColor,
      secondButtonFunction: (mafiaNumber !=
              Player.getPlayersByRoleSide(RoleSide.mafia)!.length - 1)
          ? () {
              AudioManager.playClickEffect();
              chooseSide(RoleSide.citizen);
            }
          : null,
      child: Text(
        'به نوستراداموس عدد ${Language.toPersian(mafiaNumber.toString())} رو نشون بده و ازش بپرس با کدوم ساید می‌خواد بازی کنه',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
