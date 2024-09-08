import 'package:flutter/material.dart';

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton({
    super.key,
    required this.hasIcon,
    required this.text,
    required this.color,
    required this.onTap,
    this.icon,
    this.isIconRight,
  });
  final bool hasIcon;
  final String text;
  final Color color;
  final VoidCallback onTap;
  final IconData? icon;
  final bool? isIconRight;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      iconAlignment: (isIconRight!) ? IconAlignment.start : IconAlignment.end,
      label: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        side: BorderSide(width: 3, color: color),
      ),
      icon: Container(
        //color: Colors.blue,
        //width: 35,
        child: Transform.scale(
          scale: 2.8,
          child: Icon(
            icon,
            // opticalSize: 0.5,
            color: color,
            size: 15,
          ),
        ),
      ),
    );
    if (hasIcon) {
      if (isIconRight!) {
        return MaterialButton(
          onPressed: onTap,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: color,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
                Text(
                  "$text    ",
                  style: TextStyle(
                    color: color,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return OutlinedButton.icon(
          ///padding: EdgeInsets.zero,
          onPressed: onTap,
          label: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: color,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "    $text",
                  style: TextStyle(
                    color: color,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  icon,
                  size: 40,
                  color: color,
                )
              ],
            ),
          ),
        );
      }
    } else {
      return MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: color,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$text",
                style: TextStyle(
                  color: color,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
