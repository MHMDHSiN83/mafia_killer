import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
import 'package:mafia_killer/themes/app_color.dart';

class MessageDialogbox extends StatelessWidget {
  const MessageDialogbox(
      {super.key, required this.onSave, required this.message});

  final VoidCallback onSave;
  final String message;

    @override
  Widget build(BuildContext context) {
    return DialogboxTemplate(
      firstButtonFunction: onSave,
      firstButtonText: "متوجه شدم",
      firstButtonColor: AppColors.darkgreenColor,
      //secondButtonText: "ذخیره",
      //secondButtonFunction: () {},
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.bold,
          fontSize: 12
        ),
      ),
    );
  }
  
}
