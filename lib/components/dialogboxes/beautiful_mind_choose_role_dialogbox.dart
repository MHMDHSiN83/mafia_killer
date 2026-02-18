import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/themes/app_color.dart';

class BeautifulMindChooseRoleDialogbox extends StatelessWidget {
  const BeautifulMindChooseRoleDialogbox(
      {super.key,
      required this.onCancel,
      required this.guessedWrong,
      required this.guessedRight,
      required this.player});

  final VoidCallback onCancel;
  final VoidCallback guessedWrong;
  final VoidCallback guessedRight;
  final Player player;

  @override
  Widget build(BuildContext context) {
    return DialogboxTemplate(
        firstButtonFunction: guessedRight,
        firstButtonText: "درست گفت",
        firstButtonColor: AppColors.darkgreenColor,
        secondButtonFunction: guessedWrong,
        secondButtonText: "اشتباه گفت",
        secondButtonColor: AppColors.redColor,
        thirdButtonFunction: onCancel,
        thirdButtonText: "بازگشت",
        thirdButtonColor: AppColors.darkgreenColor,
        child: Text(
          "آیا نقش ${player.name} (${player.role!.name}) را درست حدس زد؟",
        ));
  }
}
