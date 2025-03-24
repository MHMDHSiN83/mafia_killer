import 'package:flutter/material.dart';
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
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 10,
      content: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/dialogbox/DialogBoxBg.png'),
                fit: BoxFit.cover)),
        height: 240,
        width: 700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(
              flex: 5,
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                width: 180,
                child: TextField(
                  style: TextStyle(color: AppColors.brownColor, fontSize: 16),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          width: 1,
                          color: AppColors.brownColor,
                        ),
                      ),
                      // border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          width: 1,
                          color: AppColors.brownColor,
                        ),
                      ),
                      labelText: "نام بازیکن",
                      labelStyle:
                          TextStyle(color: AppColors.brownColor, fontSize: 14),
                      hintText: 'نام بازیکن را وارد کنید...',
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(167, 44, 31, 31),
                          fontSize: 14)),
                  controller: controller,
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 2,
              child: MaterialButton(
                onPressed: onSave,
                color: AppColors.brownColor,
                child: Text(
                  "ذخیره",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
