import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
import 'package:mafia_killer/themes/app_color.dart';

class ConnectionErrorDialogbox extends StatelessWidget {
  const ConnectionErrorDialogbox(
      {super.key, required this.onSave, required this.onCancel});

  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return DialogboxTemplate(
        firstButtonFunction: onCancel,
        firstButtonText: "بستن",
        firstButtonColor: AppColors.redColor,
        secondButtonFunction: onSave,
        secondButtonText: "تلاش مجدد",
        secondButtonColor: AppColors.darkgreenColor,        
        child: Text("لطفا وضعیت اتصال اینترنت را بررسی کنید"));
    
  }
}
