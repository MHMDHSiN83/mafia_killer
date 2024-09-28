import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dropdownbox.dart';

class RowDropdownBox extends StatelessWidget {
  RowDropdownBox({
    super.key,
    required this.title,
    required this.options,
    required this.onSelect,
    required this.varName,
    required this.selectedItem,
  });
  final String title;
  final List<String> options;
  final String selectedItem;
  final String varName;
  final Function(String?, String) onSelect;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        DropdownBox(
          options: options,
          selectedItem: selectedItem,
          onSelect: onSelect,
          varName: varName,
        ),
      ],
    );
  }
}
