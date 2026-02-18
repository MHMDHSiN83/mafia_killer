import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
import 'package:mafia_killer/themes/app_color.dart';

class DialogBox extends StatelessWidget {
  const DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  final TextEditingController controller;

  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return DialogboxTemplate(
      firstButtonFunction: onSave,
      firstButtonText: "ذخیره",
      firstButtonColor: AppColors.darkgreenColor,
      child: SizedBox(
        width: 180,
        child: TextField(
          style: TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.white,
                ),
              ),
              // border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.white,
                ),
              ),
              labelText: "نام بازیکن",
              labelStyle: TextStyle(color: Colors.white, fontSize: 14),
              hintText: 'نام بازیکن را وارد کنید...',
              hintStyle: TextStyle(
                  color: Colors.white, fontSize: 14)),
          controller: controller,
        ),
      ),
    );
  }
}
