import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/pages/last_move_card_page.dart';

class HandcuffsPage extends StatefulWidget {
  HandcuffsPage({super.key});
  List<Player> selectedPlayers = [];
  @override
  State<HandcuffsPage> createState() => _HandcuffsPageState();
}

class _HandcuffsPageState extends State<HandcuffsPage> {
  void addPlayer(Player player) {
    if (widget.selectedPlayers.isEmpty) {
      widget.selectedPlayers.add(player);
    }
  }

  void removePlayer(Player player) {
    if (widget.selectedPlayers.contains(player)) {
      widget.selectedPlayers.remove(player);
    }
  }

  bool isDisable(Player player) {
    bool result = true;
    setState(() {
      if (widget.selectedPlayers.isEmpty) {
        result = false;
      }
      if (widget.selectedPlayers.contains(player)) {
        result = false;
      }
    });
    return result;
  }

  List<Player> alivePlayers = Player.getAlivePlayers();

  @override
  Widget build(BuildContext context) {
    for (var p in widget.selectedPlayers) {
      print(p.name);
    }
    return Scaffold(
      body: PageFrame(
        pageTitle: "دستبند",
        leftButtonText: "کارت حرکت آخر",
        rightButtonText:
            'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
        leftButtonOnTap: () {
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          if (widget.selectedPlayers.length == 1) {
            widget.selectedPlayers
                .insert(0, Scenario.currentScenario.killedInDayPlayer!);
            LastMoveCardPage.selectedLastMoveCard!
                .lastMoveCardAction(widget.selectedPlayers, true);
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
                      "${Scenario.currentScenario.killedInDayPlayer!.name} توانایی یک نفر رو در شب بگیر.",
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
