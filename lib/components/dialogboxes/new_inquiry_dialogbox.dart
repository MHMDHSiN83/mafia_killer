import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
import 'package:mafia_killer/themes/app_color.dart';

class NewInquiryDialogbox extends StatelessWidget {
  const NewInquiryDialogbox({super.key, required this.inquiry});

  final String inquiry;
  @override
  Widget build(BuildContext context) {
    return DialogboxTemplate(
        firstButtonFunction: () {
          Navigator.pop(context);
        },
        firstButtonText: "متوجه شدم",
        firstButtonColor: AppColors.darkgreenColor,
        child: Text(
          inquiry,
        ));
  }
}
