import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 80,
      thickness: 2,
      indent: 20,
      endIndent: 20,
      color: Color(0xFF979797),
    );
  }
}
