import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class DialogboxOutlinedbutton extends StatelessWidget {
  const DialogboxOutlinedbutton(
      {super.key,
      required this.text,
      required this.color,
      required this.onClick});
  final String text;
  final Color color;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(

      
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(0),
            minimumSize: Size(300, 200),
            side: BorderSide(
              color: color,
              width: 3,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            )),
        onPressed: onClick,
        child: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 10),
        ));
  }
}
