import 'package:flutter/material.dart';
import 'package:mafia_killer/components/last_move_card_tile.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/scenario.dart';

class LastMoveCardPage extends StatefulWidget {
  const LastMoveCardPage({super.key});
  static bool canClick = true;

  @override
  State<LastMoveCardPage> createState() => _LastMoveCardPageState();
}

class _LastMoveCardPageState extends State<LastMoveCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        pageTitle: "کارت حرکت آخر",
        leftButtonText: "قبلی",
        rightButtonText: "بعدی",
        leftButtonOnTap: () {
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          Navigator.pushNamed(context, '/role_selection_page');
        },
        isInGame: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 100,
          child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: 5,
              itemBuilder: (context, index) {
                return LastMoveCardTile(
                  lastMoveCard: Scenario.currentScenario.lastMoveCards[index],
                  index: index,
                );
              }),
        ),
      ),
    );
  }
}
