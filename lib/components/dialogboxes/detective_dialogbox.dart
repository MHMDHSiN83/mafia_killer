import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
import 'package:mafia_killer/themes/app_color.dart';

class DetectiveDialogbox extends StatelessWidget {
  const DetectiveDialogbox(
      {super.key, required this.text, required this.onSave});

  final VoidCallback onSave;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DialogboxTemplate(
        firstButtonFunction: onSave,
        firstButtonText: 'متوجه شدم',
        firstButtonColor: AppColors.darkgreenColor,
        child: Text(text));
  }
}
