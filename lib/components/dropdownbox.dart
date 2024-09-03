import 'package:flutter/material.dart';

class DropdownBox extends StatefulWidget {
  DropdownBox(
      {super.key,
      required this.options,
      required this.onSelecte,
      required this.selectedItem});
  final List<String> options;
  final Function(String?) onSelecte;
  String selectedItem;

  @override
  State<DropdownBox> createState() => _DropdownBoxState();
}

class _DropdownBoxState extends State<DropdownBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 40,
      child: DropdownButtonFormField<String>(
        value: widget.selectedItem,
        onChanged: widget.onSelecte,
        isExpanded: true,
        dropdownColor: Color(0xFF382E2E),
        decoration: const InputDecoration(
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          )),
          contentPadding: EdgeInsets.symmetric(vertical: -20, horizontal: 10),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Color(0xFF07FFB5),
          size: 38,
        ),
        items: widget.options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          );
        }).toList(),
      ),
    );
  }
}
