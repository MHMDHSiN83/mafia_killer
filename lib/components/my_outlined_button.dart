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
    if (hasIcon) {
      if (isIconRight!) {
        return GestureDetector(
          onTap: onTap,
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
        return Container(
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
        );
      }
    } else {
      return GestureDetector(
        onTap: onTap,
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
