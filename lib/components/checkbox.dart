import 'package:flutter/material.dart';

class MyCheckBox extends StatelessWidget {
  final bool isChecked;
  final void Function(bool?) onChanged;
  final double scale;
  const MyCheckBox(
      {super.key,
      required this.isChecked,
      required this.onChanged,
      required this.scale});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Checkbox(
        value: isChecked,
        checkColor: Theme.of(context).colorScheme.inversePrimary,
        onChanged: onChanged,
        fillColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.green; // Checked state
          }
          return Colors.white; // Unchecked state
        }),
      ),
    );
  }
}
