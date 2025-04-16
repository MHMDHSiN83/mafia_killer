import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/dialogboxes/message_dialogbox.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/beautiful_mind.dart';
import 'package:mafia_killer/pages/last_move_card_page.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/utils/settings_page.dart';

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
    setState(() {
      selectedPlayers.add(player);
      if (selectedPlayers.length == 2) {
        selectedPlayers.removeAt(0);
      }
    });
  }

  void removePlayer(Player player) {
    setState(() {
      if (selectedPlayers.contains(player)) {
        selectedPlayers.remove(player);
      }
    });
  }

  List<Player> alivePlayers = Player.getAliveInGamePlayers();

  bool isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        label: '/beautiful_mind_choose_nostradamus_page',
        pageTitle: "ذهن زیبا",
        settingsPage: () {
          if (LastMoveCardPage.selectedLastMoveCard != null) {
            LastMoveCardPage.selectedLastMoveCard!.isUsed = false;
          }
          return settingsPage(context, 7);
        },
        leftButtonText: "کارت حرکت آخر",
        rightButtonText:
            'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          if (isConfirmed && selectedPlayers.length == 1) {
            GameStateManager.addLastMoveCardAction([
              Scenario.currentScenario.killedInDayPlayer!,
              selectedPlayers[0]
            ], LastMoveCardPage.selectedLastMoveCard!);
            LastMoveCardPage.selectedLastMoveCard!.lastMoveCardAction([
              Player.getPlayerByName(
                  Scenario.currentScenario.killedInDayPlayer!.name),
              Player.getPlayerByName(selectedPlayers[0].name)
            ]);
            Scenario.currentScenario.goToNextStage();

            // in case the game ended
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
                      stamp: "نوستراداموس",
                      player: alivePlayers[index],
                      addPlayer: () {
                        addPlayer(alivePlayers[index]);
                      },
                      removePlayer: () {
                        removePlayer(alivePlayers[index]);
                      },
                      isClicked: selectedPlayers.contains(alivePlayers[index]),
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
                            return MessageDialogbox(
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
