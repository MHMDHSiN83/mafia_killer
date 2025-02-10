import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/message_box.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/beautiful_mind.dart';
import 'package:mafia_killer/pages/last_move_card_page.dart';

class BeautifulMindChooseNostradamusPage extends StatefulWidget {
  const BeautifulMindChooseNostradamusPage({super.key});
  static String message = "";

  @override
  State<BeautifulMindChooseNostradamusPage> createState() =>
      _BeautifulMindChooseNostradamusPageState();
}

class _BeautifulMindChooseNostradamusPageState
    extends State<BeautifulMindChooseNostradamusPage> {
  List<Player> selectedPlayers = [];
  void addPlayer(Player player) {
    if (selectedPlayers.isEmpty) {
      selectedPlayers.add(player);
    }
  }

  void removePlayer(Player player) {
    if (selectedPlayers.contains(player)) {
      selectedPlayers.remove(player);
    }
  }

  bool isDisable(Player player) {
    bool result = true;
    setState(() {
      if (selectedPlayers.isEmpty) {
        result = false;
      }
      if (selectedPlayers.contains(player)) {
        result = false;
      }
    });
    return result;
  }

  List<Player> alivePlayers = Player.players
      .where((player) => (player.playerStatus == PlayerStatus.active))
      .toList();

  bool isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    for (var p in selectedPlayers) {
      print(p.name);
    }
    print(isConfirmed);
    return Scaffold(
      body: PageFrame(
        label: ModalRoute.of(context)!.settings.name!,
        pageTitle: "ذهن زیبا",
        leftButtonText: "کارت حرکت آخر",
        rightButtonText:
            'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          if (isConfirmed && selectedPlayers.length == 1) {
            print("testtt");
            selectedPlayers.insert(
                0, Scenario.currentScenario.killedInDayPlayer!);
            LastMoveCardPage.selectedLastMoveCard!
                .lastMoveCardAction(selectedPlayers);
            print("testtt2");

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
                      stamp: "نوستراداموس",
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
                      "${Scenario.currentScenario.killedInDayPlayer!.name} اگر نوستراداموس بازی رو درست حدس بزنی در بازی میمونی",
                  buttonText: "انتخاب کردم",
                  onPressed: () {
                    if (selectedPlayers.length == 1) {
                      selectedPlayers.insert(
                          0, Scenario.currentScenario.killedInDayPlayer!);
                      showDialog(
                          context: context,
                          builder: (context) {
                            (LastMoveCardPage.selectedLastMoveCard!
                                    as BeautifulMind)
                                .lastMoveCardMessage(selectedPlayers);
                            isConfirmed = true;
                            selectedPlayers.removeAt(0);
                            return MessageBox(
                                onSave: () {
                                  Navigator.pop(context);
                                },
                                message:
                                    BeautifulMindChooseNostradamusPage.message);
                          });
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
