import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/pages/last_move_card_page.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/utils/settings_page.dart';

class HandcuffsPage extends StatefulWidget {
  HandcuffsPage({super.key});
  List<Player> selectedPlayers = [];
  @override
  State<HandcuffsPage> createState() => _HandcuffsPageState();
}

class _HandcuffsPageState extends State<HandcuffsPage> {
  void addPlayer(Player player) {
    setState(() {
      widget.selectedPlayers.add(player);
      if (widget.selectedPlayers.length == 2) {
        widget.selectedPlayers.removeAt(0);
      }
    });
  }

  void removePlayer(Player player) {
    setState(() {
      if (widget.selectedPlayers.contains(player)) {
        widget.selectedPlayers.remove(player);
      }
    });
  }

  Player killedInDayPlayer = Scenario.currentScenario.killedInDayPlayer!;
  List<Player> alivePlayers =
      Player.getAlivePlayersExcept(Scenario.currentScenario.killedInDayPlayer!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        label: '/handcuffs_page',
        pageTitle: "دستبند",
        settingsPage: () {
          if (LastMoveCardPage.selectedLastMoveCard != null) {
            LastMoveCardPage.selectedLastMoveCard!.isUsed = false;
          }
          return settingsPage(context, 7);
        },
        leftButtonText: "کارت حرکت آخر",
        rightButtonText: 'شب ${GameStateManager.getNextStateNumber()}',
        leftButtonOnTap: () {
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          if (widget.selectedPlayers.length == 1) {
            // widget.selectedPlayers.insert(0, killedInDayPlayer);
            GameStateManager.addLastMoveCardAction([
              Scenario.currentScenario.killedInDayPlayer!,
              widget.selectedPlayers[0]
            ], LastMoveCardPage.selectedLastMoveCard!);
            LastMoveCardPage.selectedLastMoveCard!.lastMoveCardAction([
              Player.getPlayerByName(
                  Scenario.currentScenario.killedInDayPlayer!.name),
              Player.getPlayerByName(widget.selectedPlayers[0].name),
            ]);

            if (Scenario.currentScenario.isGameOver()) {
              AudioManager.playNextPageEffect();
              Navigator.pushNamed(context, '/end_game_page');
            } else {
              AudioManager.playNextPageEffect();
              Navigator.pushNamed(context, '/night_page');
            }
          } else {
            customSnackBar(
                context, "باید حتما یک بازیکن را انتخاب کنید.", true);
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
                      addPlayer: () {
                        addPlayer(alivePlayers[index]);
                      },
                      removePlayer: () {
                        removePlayer(alivePlayers[index]);
                      },
                      isClicked:
                          widget.selectedPlayers.contains(alivePlayers[index]),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                child: CallRole(
                  text:
                      "${killedInDayPlayer.name} توانایی یک نفر رو در شب بگیر.",
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
