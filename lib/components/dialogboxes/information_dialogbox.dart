import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
import 'package:mafia_killer/themes/app_color.dart';

class InformationDialogbox extends StatelessWidget {
  const InformationDialogbox(
      {super.key, required this.text, required this.onSave});

  final VoidCallback onSave;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DialogboxTemplate(
      firstButtonFunction: onSave,
      firstButtonText: "متوجه شدم",
      firstButtonColor: AppColors.darkgreenColor,
      //secondButtonText: "ذخیره",
      //secondButtonFunction: () {},
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
