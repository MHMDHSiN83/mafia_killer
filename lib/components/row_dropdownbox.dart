import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dropdownbox.dart';

class RowDropdownBox extends StatelessWidget {
  RowDropdownBox({
    super.key,
    required this.title,
    required this.options,
    required this.onSelecte,
  });
  final String title;
  final List<String> options;
  // String selectedItem;
  final Function(String?) onSelecte;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        DropdownBox(
          options: options,
          selectedItem: options.first,
          onSelecte: onSelecte,
        ),
      ],
    );
  }
}
