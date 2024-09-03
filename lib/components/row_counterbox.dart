import 'package:flutter/material.dart';
import 'package:mafia_killer/components/counterbox.dart';
import 'package:mafia_killer/components/dropdownbox.dart';

class RowCounterBox extends StatelessWidget {
  RowCounterBox({
    super.key,
    required this.title,
    required this.increaseNumber,
    required this.decreaseNumber,
    required this.number,
  });
  final String title;
  // String selectedItem;
  String number;
  final Function() increaseNumber;
  final Function() decreaseNumber;
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
        CounterBox(
          increaseNumber: increaseNumber,
          decreaseNumber: decreaseNumber,
          number: number,
        ),
      ],
    );
  }
}
