import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
import 'package:mafia_killer/themes/app_color.dart';

class MusketeerDialogbox extends StatelessWidget {
  const MusketeerDialogbox({
    super.key,
    required this.fakeBullet,
    required this.realBullet,
  });

  final VoidCallback fakeBullet;
  final VoidCallback realBullet;

  @override
  Widget build(BuildContext context) {
    return DialogboxTemplate(
        firstButtonFunction: fakeBullet,
        firstButtonText: "مشقی",
        firstButtonColor: AppColors.darkgreenColor,
        secondButtonFunction: realBullet,
        secondButtonText: "جنگی",
        secondButtonColor: AppColors.redColor,
        thirdButtonFunction: () => {Navigator.pop(context)},
        thirdButtonText: "بازگشت",
        thirdButtonColor: AppColors.yellowColor,
        child: Text("تفنگدار بگه تیرش جنگیه یا مشقی"));
  }
}
