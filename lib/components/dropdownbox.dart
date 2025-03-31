import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class DropdownBox extends StatelessWidget {
  const DropdownBox({
    super.key,
    required this.options,
    required this.onSelect,
    required this.selectedItem,
    required this.varName,
  });
  final List<String> options;
  final Function(String?, String) onSelect;
  final String varName;
  final String selectedItem;

  @override
  Widget build(BuildContext context) {
    options.add("کلاسیک (به‌زودی)");
    options.add("زودیاک (به‌زودی)");
    return SizedBox(
      width: 140,
      height: 40,
      child: DropdownButtonFormField<String>(
          value: selectedItem,
          onChanged: (String? selectedItem) => onSelect(selectedItem, varName),
          isExpanded: true,
          dropdownColor: const Color(0xFF382E2E),
          decoration: const InputDecoration(
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            contentPadding: EdgeInsets.symmetric(vertical: -20, horizontal: 10),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.greenColor,
            size: 38,
          ),
          items: options.asMap().entries.map<DropdownMenuItem<String>>((entry) {
            int index = entry.key;
            String value = entry.value;
            bool isDisabled = index > 0;
            return DropdownMenuItem<String>(
              value: isDisabled ? null : value,
              enabled: !isDisabled,
              child: Text(
                value,
                style: TextStyle(
                  color: isDisabled
                      ? Colors.grey
                      : Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                ),
              ),
            );
          }).toList()),
    );
  }
}
