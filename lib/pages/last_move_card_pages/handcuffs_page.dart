import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/pages/last_move_card_page.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';
import 'package:mafia_killer/utils/audio_manager.dart';

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
        label: ModalRoute.of(context)!.settings.name!,
        pageTitle: "دستبند",
        leftButtonText: "کارت حرکت آخر",
        rightButtonText:
            'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
        leftButtonOnTap: () {
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          if (widget.selectedPlayers.length == 1) {
            widget.selectedPlayers.insert(0, killedInDayPlayer);
            LastMoveCardPage.selectedLastMoveCard!
                .lastMoveCardAction(widget.selectedPlayers);
            AudioManager.playNextPageEffect();
            Navigator.pushNamed(context, '/night_page');
          } else {
            customSnackBar(context, "باید حتما یک بازیکن را انتخاب کنید.", true);
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
