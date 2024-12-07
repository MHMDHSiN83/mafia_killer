import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/last_move_card_tile.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/reveal_identity.dart';

class LastMoveCardPage extends StatefulWidget {
  const LastMoveCardPage({super.key});
  static bool canClick = true;
  static LastMoveCard? selectedLastMoveCard;

  @override
  State<LastMoveCardPage> createState() => _LastMoveCardPageState();
}

class _LastMoveCardPageState extends State<LastMoveCardPage> {
  @override
  void initState() {
    super.initState();
    LastMoveCardPage.canClick = true;
  }

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
          LastMoveCardPage.selectedLastMoveCard!.isUsed = true;
          if (LastMoveCardPage.selectedLastMoveCard is RevealIdentity) {
            Navigator.pushNamed(context, '/reveal_identity_page');
          }
          else{
            Navigator.pushNamed(context, '/night_page');
          }
          
        },
        isInGame: true,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return LastMoveCardTile(
                      lastMoveCard:
                          Scenario.currentScenario.lastMoveCards[index],
                      index: index,
                    );
                  }),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CallRole(
                  text:
                      "${GodfatherScenario.killedInDayPlayer!.name} کشته امروز است و باید کارت حرکت آخر انتخاب کند",
                  buttonText: "",
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
