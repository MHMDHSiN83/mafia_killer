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

class HandcuffsPage extends StatefulWidget {
  const HandcuffsPage({super.key});
  static List<Player> selectedPlayers = [];
  @override
  State<HandcuffsPage> createState() => _HandcuffsPageState();
}

class _HandcuffsPageState extends State<HandcuffsPage> {
  void addPlayer(Player player) {
    if (HandcuffsPage.selectedPlayers.isEmpty) {
      HandcuffsPage.selectedPlayers.add(player);
    }
  }

  void removePlayer(Player player) {
    if (HandcuffsPage.selectedPlayers.contains(player)) {
      HandcuffsPage.selectedPlayers.remove(player);
    }
  }

  bool isDisable(Player player) {
    bool result = true;
    setState(() {
      if (HandcuffsPage.selectedPlayers.isEmpty) {
        result = false;
      }
      if (HandcuffsPage.selectedPlayers.contains(player)) {
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
        pageTitle: "دستبند",
        leftButtonText: "کارت حرکت آخر",
        rightButtonText:
            'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          if (HandcuffsPage.selectedPlayers.length == 1) {
            LastMoveCardPage.selectedLastMoveCard!
                .lastMoveCardAction(HandcuffsPage.selectedPlayers, true);
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
                      stamp: "دستبند",
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
                      "${GodfatherScenario.killedInDayPlayer!.name} توانایی یک نفر رو در شب بگیر.",
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
