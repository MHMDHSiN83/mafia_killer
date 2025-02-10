import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/pages/last_move_card_page.dart';

class SilenceOfTheLambsPage extends StatefulWidget {
  SilenceOfTheLambsPage({super.key});
  List<Player> selectedPlayers = [];
  @override
  State<SilenceOfTheLambsPage> createState() => _SilenceOfTheLambsPageState();
}

class _SilenceOfTheLambsPageState extends State<SilenceOfTheLambsPage> {
  void addPlayer(Player player) {
    if (widget.selectedPlayers.length < 2) {
      widget.selectedPlayers.add(player);
    }
  }

  void removePlayer(Player player) {
    if (widget.selectedPlayers.contains(player)) {
      widget.selectedPlayers.remove(player);
    }
  }

  bool isDisable(Player player) {
    bool result = false;
    setState(() {
      if (widget.selectedPlayers.length == 2) {
        result = true;
      }
      if (widget.selectedPlayers.contains(player)) {
        result = false;
      }
    });
    return result;
  }
  Player killedInDayPlayer = Scenario.currentScenario.killedInDayPlayer!;
  List<Player> alivePlayers = Player.getAlivePlayersExcept(Scenario.currentScenario.killedInDayPlayer!);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        label: ModalRoute.of(context)!.settings.name!,
        pageTitle: "سکوت بره ها",
        leftButtonText: "کارت حرکت آخر",
        rightButtonText:
            'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          if (widget.selectedPlayers.length == 2) {
            widget.selectedPlayers
                .insert(0, killedInDayPlayer);
            LastMoveCardPage.selectedLastMoveCard!.lastMoveCardAction(
                widget.selectedPlayers);
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
                      "${killedInDayPlayer.name} دو نفرو انتخاب کن که فردا صبح ساکت باشن.",
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
