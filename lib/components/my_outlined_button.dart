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
      iconAlignment: (icon == null)
          ? IconAlignment.start
          : (isIconRight!)
              ? IconAlignment.start
              : IconAlignment.end,
      label: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(width: 3, color: color),
      ),
      icon: Transform.scale(
        scale: 2.8,
        child: (icon == null)
            ? null
            : Icon(
                icon,
                color: color,
                size: 15,
              ),
      ),
    );
  }
}
