import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/dialogboxes/message_dialogbox.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';

class DefenseVotingPage extends StatefulWidget {
  const DefenseVotingPage({super.key});

  @override
  State<DefenseVotingPage> createState() => _DefenseVotingPageState();
}

class _DefenseVotingPageState extends State<DefenseVotingPage> {
  bool isDeathLotterySelected = false;
  bool isCleared = false;

  List<Player> selectedPlayers = [];

  Map<Player, bool> playerBoxStatus = {};

  void addPlayer(Player player) {
    // if ((selectedPlayers.isEmpty && !isDeathLotterySelected) ||
    //     (selectedPlayers.length < 2 && isDeathLotterySelected)) {
    //   selectedPlayers.add(player);
    // }
    setState(() {
      selectedPlayers.add(player);
      if ((selectedPlayers.length == 2 && !isDeathLotterySelected) ||
          selectedPlayers.length == 3) {
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

  @override
  void initState() {
    for (Player player in Scenario.currentScenario.defendingPlayers) {
      playerBoxStatus[player] = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        label: '/defense_voting_page',
        pageTitle: "کشته روز",
        reloadContentOfPage: () {
          setState(() {});
        },
        leftButtonText: "صحبت دفاعیه",
        rightButtonText:
            'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          Scenario.currentScenario.goToNextStage();
          switch (selectedPlayers.length) {
            case 1:
              Scenario.currentScenario.killedInDayPlayer = selectedPlayers[0];
              break;
            case 2:
              final random = Random();
              int randomNumber = random.nextInt(2);
              Scenario.currentScenario.killedInDayPlayer =
                  selectedPlayers[randomNumber];
              break;
          }

          if (Scenario.currentScenario is GodfatherScenario) {
            (Scenario.currentScenario as GodfatherScenario)
                .resetSilencedPlayersBeforeLastMoveCardPage();
          }
          AudioManager.playNextPageEffect();
          Navigator.pushNamed(
            context,
            (selectedPlayers.isEmpty) ? '/night_page' : '/last_move_card_page',
          );
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
                  itemCount: Scenario.currentScenario.defendingPlayers.length,
                  itemBuilder: (context, index) {
                    return VotingTile(
                      player: Scenario.currentScenario.defendingPlayers[index],
                      addPlayer: () {
                        addPlayer(
                            Scenario.currentScenario.defendingPlayers[index]);
                      },
                      removePlayer: () {
                        removePlayer(
                            Scenario.currentScenario.defendingPlayers[index]);
                      },
                      isClicked: selectedPlayers.contains(
                          Scenario.currentScenario.defendingPlayers[index]),
                      stamp: 'کشته',
                      // isDisable(Scenario.currentScenario.defendingPlayers[index]),
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
                      "اگه دو نفر تعداد رای‌هاشون یکسان شد از قرعه مرگ استفاده کن",
                  buttonText: "قرعه مرگ",
                  onPressed: () {
                    isDeathLotterySelected = true;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return MessageDialogbox(
                          message:
                              'حالا دو نفر رو انتخاب کن بعدی رو بزن تا به صورت تصادفی یه نفر بره به مرحله کارت حرکت آخر',
                          onSave: () => Navigator.of(context).pop(),
                        );
                      },
                    );
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
