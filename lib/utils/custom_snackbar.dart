import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

void customSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary,
        fontSize: 14,
      ),
    ),
    backgroundColor: Theme.of(context).colorScheme.primary,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    action: SnackBarAction(
      label: 'فهمیدم',
      onPressed: () {},
      textColor: Colors.green, // Replace with AppColors.greenColor if needed
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}