import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
import 'package:mafia_killer/themes/app_color.dart';

class ConfirmationDialogbox extends StatelessWidget {
  const ConfirmationDialogbox(
      {super.key, required this.onSave, required this.onCancel});

  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return DialogboxTemplate(
        firstButtonFunction: onSave,
        firstButtonText: "بله",
        firstButtonColor: AppColors.darkgreenColor,
        secondButtonFunction: onCancel,
        secondButtonText: "خیر",
        secondButtonColor: AppColors.redColor,
        child: Text("آیا از انتخاب خود مطمئنید؟"));
  }
}
