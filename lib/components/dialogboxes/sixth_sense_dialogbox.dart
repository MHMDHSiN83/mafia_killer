import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
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
    return DialogboxTemplate(
        firstButtonFunction: guessedRight,
        firstButtonText: "درست گفت",
        firstButtonColor: AppColors.darkgreenColor,
        secondButtonFunction: guessedWrong,
        secondButtonText: "اشتباه گفت",
        secondButtonColor: AppColors.redColor,
        child: Text(
          "آیا پدرخوانده نقش ${player.name} (${player.role!.name}) را درست حدس زد؟",
        ));
  }
}
