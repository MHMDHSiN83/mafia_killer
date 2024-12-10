import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/message_box.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/pages/last_move_card_page.dart';

class SilenceOfTheLambsPage extends StatefulWidget {
  const SilenceOfTheLambsPage({super.key});
  static List<Player> selectedPlayers = [];
  @override
  State<SilenceOfTheLambsPage> createState() => _SilenceOfTheLambsPageState();
}

class _SilenceOfTheLambsPageState extends State<SilenceOfTheLambsPage> {
  void addPlayer(Player player) {
    if (SilenceOfTheLambsPage.selectedPlayers.length < 2) {
      SilenceOfTheLambsPage.selectedPlayers.add(player);
    }
  }

  void removePlayer(Player player) {
    if (SilenceOfTheLambsPage.selectedPlayers.contains(player)) {
      SilenceOfTheLambsPage.selectedPlayers.remove(player);
    }
  }

  bool isDisable(Player player) {
    bool result = false;
    setState(() {
      if (SilenceOfTheLambsPage.selectedPlayers.length == 2) {
        result = true;
      }
      if (SilenceOfTheLambsPage.selectedPlayers.contains(player)) {
        result = false;
      }
    });
    return result;
  }

  List<Player> alivePlayers = Player.players
      .where((player) => (player.playerStatus == PlayerStatus.active))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        pageTitle: "سکوت بره ها",
        leftButtonText: "کارت حرکت آخر",
        rightButtonText:
            'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          if (SilenceOfTheLambsPage.selectedPlayers.length == 2) {
            LastMoveCardPage.selectedLastMoveCard!.lastMoveCardAction(
                SilenceOfTheLambsPage.selectedPlayers, true);
            Navigator.pushNamed(context, '/night_page');
          }
        },
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of tiles per row
                    childAspectRatio: 1, // Width/height ratio of tiles
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                  ),
                  itemCount: alivePlayers.length,
                  itemBuilder: (context, index) {
                    return VotingTile(
                      stamp: "سکوت",
                      player: alivePlayers[index],
                      isRegularVoting: false,
                      addPlayer: () {
                        addPlayer(alivePlayers[index]);
                      },
                      removePlayer: () {
                        removePlayer(alivePlayers[index]);
                      },
                      disable: () => isDisable(alivePlayers[index]),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CallRole(
                  text:
                      "${GodfatherScenario.killedInDayPlayer!.name} دو نفرو انتخاب کن که فردا صبح ساکت باشن.",
                  buttonText: "",
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
