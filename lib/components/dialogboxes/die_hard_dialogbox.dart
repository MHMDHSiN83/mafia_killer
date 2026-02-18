import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
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
    return DialogboxTemplate(
        firstButtonFunction: takeInquiry,
        firstButtonText: "می‌گیره",
        firstButtonColor: AppColors.darkgreenColor,
        secondButtonFunction: notTakeInquiry,
        secondButtonText: "نمی‌گیره",
        secondButtonColor: AppColors.redColor,
        child: Text("جان سخت بیدار شه و بگه که استعلام می‌گیره یا نه"));
  }
}
