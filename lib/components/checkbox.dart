import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  bool isChecked;
  void Function(bool?) onChanged;
  double scale;
  MyCheckBox(
      {super.key,
      required this.isChecked,
      required this.onChanged,
      required this.scale});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale,
      child: Checkbox(
        value: widget.isChecked,
        checkColor: Theme.of(context).colorScheme.inversePrimary,
        onChanged: widget.onChanged,
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
