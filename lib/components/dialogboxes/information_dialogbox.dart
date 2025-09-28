import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template.dart';
import 'package:mafia_killer/themes/app_color.dart';

class InformationDialogbox extends StatelessWidget {
  const InformationDialogbox(
      {super.key, required this.text, required this.onSave});

  final VoidCallback onSave;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DialogboxTemplate(
        onSave: onSave,
        onCancel: () {},
        firstButtonText: "متوجه شدم",
        text: text);
  }
}
