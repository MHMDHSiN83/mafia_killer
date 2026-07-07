import 'package:flutter/material.dart';
import 'package:mafia_killer/components/bomber_counterbox.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
import 'package:mafia_killer/components/row_counterbox.dart';
import 'package:mafia_killer/themes/app_color.dart';

class BomberDialogbox extends StatefulWidget {
  const BomberDialogbox({
    super.key,
    required this.setPassword,
  });

  final Function(int) setPassword;

  @override
  State<BomberDialogbox> createState() => _BomberDialogboxState();
}

class _BomberDialogboxState extends State<BomberDialogbox> {
  int currentNumber = 1;

  void _increase() {
    setState(() {
      currentNumber = (currentNumber + 1) % 4;
    });
  }

  void _decrease() {
    setState(() {
      currentNumber = (currentNumber - 1) % 4 ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogboxTemplate(
      firstButtonFunction: () => widget.setPassword(currentNumber + 1),
      firstButtonText: "تایید",
      firstButtonColor: AppColors.darkgreenColor,
      secondButtonFunction: () => Navigator.pop(context),
      secondButtonText: "بازگشت",
      secondButtonColor: AppColors.redColor,
      child: Row(
        children: [
          Text("رمز بمب: "),
          BomberCounterbox(
              increaseNumber: _increase,
              decreaseNumber: _decrease,
              number: currentNumber + 1)
        ],
      ),
    );
  }
}
