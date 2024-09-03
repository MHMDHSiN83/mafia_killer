import 'package:flutter/material.dart';

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
        backgroundColor: Color(0xFF382E2E),
        elevation: 10,
        content: SizedBox(
            height: 160,
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      // border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      labelText: "نام بازیکن",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 20),
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
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Color(0xFF17C692),
                    ),
                    MaterialButton(
                      onPressed: onCancel,
                      child: Text(
                        "بازگشت",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Color(0xFFE01357),
                    )
                  ],
                )
              ],
            )));
  }
}
