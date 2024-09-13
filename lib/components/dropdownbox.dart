import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class DropdownBox extends StatefulWidget {
  DropdownBox({
    super.key,
    required this.options,
    required this.onSelect,
    required this.selectedItem,
    required this.varName,
  });
  final List<String> options;
  final Function(String?, String) onSelect;
  final String varName;
  String selectedItem;

  @override
  State<DropdownBox> createState() => _DropdownBoxState();
}

class _DropdownBoxState extends State<DropdownBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 40,
      child: DropdownButtonFormField<String>(
        value: widget.selectedItem,
        onChanged: (String? selectedItem) =>
            widget.onSelect(selectedItem, widget.varName),
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
        items: widget.options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                fontSize: 16,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
