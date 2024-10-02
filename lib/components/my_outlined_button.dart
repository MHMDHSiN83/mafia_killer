import 'package:flutter/material.dart';

class MyOutlinedButton extends StatelessWidget {
  MyOutlinedButton({
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

  final Map<String, double> ButtonFontsizes = {
    "small": 22,
    "medium": 26,
    "large": 30
  };
  double determineButtonFontsize() {
    double len = text.length.toDouble();
    int numberOfWords = text.split(' ').length;
    if (len <= 10 && numberOfWords <= 2) {
      return ButtonFontsizes["large"]!;
    } else if ((len > 10 && len <= 14 && numberOfWords <= 2) ||
        (len <= 12 && numberOfWords > 2)) {
      return ButtonFontsizes["medium"]!;
    } else {
      return ButtonFontsizes["small"]!;
    }
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: determineButtonFontsize()),
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
