import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class NightEventTile extends StatelessWidget {
  const NightEventTile({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 9, left: 10),
          child: const Icon(
            Icons.circle,
            color: AppColors.brownColor,
            size: 18,
          ),
        ),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.brownColor,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
