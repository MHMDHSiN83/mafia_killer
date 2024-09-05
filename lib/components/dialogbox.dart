import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class DialogBox extends StatelessWidget {
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  final TextEditingController controller;

  VoidCallback onSave;
  VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 10,
        content: SizedBox(
            height: 160,
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      // border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      labelText: "نام بازیکن",
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 20),
                      hintText: 'نام بازیکن را وارد کنید...',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(139, 255, 255, 255))),
                  controller: controller,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: onSave,
                      child: Text(
                        "ذخیره",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold),
                      ),
                      color: AppColors.darkgreenColor,
                    ),
                    MaterialButton(
                      onPressed: onCancel,
                      child: Text(
                        "بازگشت",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold),
                      ),
                      color: AppColors.redColor,
                    )
                  ],
                )
              ],
            )));
  }
}
