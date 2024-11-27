import 'package:flutter/material.dart';
import 'package:mafia_killer/components/page_frame.dart';

class LastMoveCardPage extends StatelessWidget {
  const LastMoveCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      pageTitle: "کارت حرکت آخر",
      leftButtonText: "بعدی",
      rightButtonText: "قبلی",
      leftButtonOnTap: (){},
      rightButtonOnTap: (){},
      isInGame: true,
      child: Container(
        height: 1000,
        child: ListView(
          children: [
            
          ],
        ),
      ),
    );
  }
}