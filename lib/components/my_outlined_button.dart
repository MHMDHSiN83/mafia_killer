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
    this.fontSize,
    this.iconSize,
    this.textColor,
    this.backgroundColor,
    this.broderWidth,
    this.horizontalPadding,
    this.iconFlip = false,
  });
  final bool hasIcon;
  final String text;
  final Color color;
  final VoidCallback onTap;
  final bool iconFlip;
  final IconData? icon;
  final bool? isIconRight;
  final double? fontSize;
  final double? iconSize;
  final Color? textColor;
  final Color? backgroundColor;
  final double? broderWidth;
  final double? horizontalPadding;

  final Map<String, double> buttonFontsizes = {
    "small": 18,
    "medium": 20,
    "large": 24
  };
  double determineButtonFontsize() {
    double len = text.length.toDouble();
    int numberOfWords = text.split(' ').length;
    if (len <= 10 && numberOfWords <= 2) {
      return buttonFontsizes["large"]!;
    } else if ((len > 10 && len <= 14 && numberOfWords <= 2) ||
        (len <= 12 && numberOfWords > 2)) {
      return buttonFontsizes["medium"]!;
    } else {
      return buttonFontsizes["small"]!;
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
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 4),
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
              color: textColor ?? color,
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? determineButtonFontsize()),
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(width: broderWidth ?? 4, color: color),
      ),
      icon: Transform.scale(
        scale: 2.8,
        child: (icon == null)
            ? null
            : Transform.flip(
                flipX: iconFlip,
                child: Icon(
                  icon,
                  color: textColor ?? color,
                  size: iconSize ?? 15,
                ),
              ),
      ),
    );
  }
}
