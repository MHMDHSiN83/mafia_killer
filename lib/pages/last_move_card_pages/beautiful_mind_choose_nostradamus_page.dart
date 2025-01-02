import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/message_box.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';

class BeautifulMindChooseNostradamusPage extends StatefulWidget {
  const BeautifulMindChooseNostradamusPage({super.key});
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
    return Scaffold(
      body: PageFrame(
        pageTitle: "ذهن زیبا",
        leftButtonText: "کارت حرکت آخر",
        rightButtonText:
            'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          if (isConfirmed && selectedPlayers.length == 1) {
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
                      "${GodfatherScenario.killedInDayPlayer!.name} اگر نوستراداموس بازی رو درست حدس بزنی در بازی میمونی",
                  buttonText: "انتخاب کردم",
                  onPressed: () {
                    if (selectedPlayers.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            String message = "";
                            // killed player in day be nostradamus
                            if (GodfatherScenario.killedInDayPlayer!.name ==
                                    selectedPlayers[0].name &&
                                GodfatherScenario.killedInDayPlayer!.role!
                                    is Nostradamus) {
                              message =
                                  "${GodfatherScenario.killedInDayPlayer!.name} خودش نوستراداموس بازی است و به بازی میگردد ولی شیلدش می افتد.";
                              (GodfatherScenario.killedInDayPlayer!.role!
                                      as Nostradamus)
                                  .shield = false;
                            }
                            // guess the nostradamus correctly
                            else if (selectedPlayers[0].role! is Nostradamus) {
                              message =
                                  "${selectedPlayers[0].name} نوستراداموس است و از بازی به طور کامل خارج شده و ${GodfatherScenario.killedInDayPlayer!.name} در بازی می‌ماند";
                              selectedPlayers[0].playerStatus =
                                  PlayerStatus.removed;
                            }
                            // guess the nostradamus wrong
                            else {
                              message =
                                  "${selectedPlayers[0].name} نوستراداموس بازی نیست پس ${GodfatherScenario.killedInDayPlayer!.name} از بازی خارج میشود.";
                              GodfatherScenario.killedInDayPlayer!
                                  .playerStatus = PlayerStatus.dead;
                            }
                            return MessageBox(
                                onSave: () {
                                  isConfirmed = true;
                                  Navigator.pop(context);
                                },
                                message: message);
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
