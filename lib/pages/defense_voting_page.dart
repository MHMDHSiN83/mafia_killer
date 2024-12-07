import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/message_box.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
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
    if ((selectedPlayers.isEmpty && !isDeathLotterySelected) ||
        (selectedPlayers.length < 2 && isDeathLotterySelected)) {
      selectedPlayers.add(player);
    }
  }

  void removePlayer(Player player) {
    if (selectedPlayers.contains(player)) {
      selectedPlayers.remove(player);
    }
  }

  bool isDisable(Player player) {
    bool result = false;
    setState(() {
      if ((selectedPlayers.isNotEmpty && !isDeathLotterySelected) ||
          (selectedPlayers.length == 2 && isDeathLotterySelected)) {
        result = true;
      }
      if (selectedPlayers.contains(player)) {
        result = false;
      }
    });
    return result;
  }

  @override
  void initState() {
    for (Player player in GodfatherScenario.defendingPlayers) {
      playerBoxStatus[player] = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        pageTitle: "کشته روز",
        leftButtonText: "صحبت دفاعیه",
        rightButtonText:
            'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          Scenario.currentScenario.goToNextStage();
          switch (selectedPlayers.length) {
            case 1:
              GodfatherScenario.killedInDayPlayer = selectedPlayers[0];
              break;
            case 2:
              final random = Random();
              int randomNumber = random.nextInt(2);
              GodfatherScenario.killedInDayPlayer =
                  selectedPlayers[randomNumber];
              break;
            default:
              break;
          }
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
                  itemCount: GodfatherScenario.defendingPlayers.length,
                  itemBuilder: (context, index) {
                    return VotingTile(
                      player: GodfatherScenario.defendingPlayers[index],
                      isRegularVoting: false,
                      addPlayer: () {
                        addPlayer(GodfatherScenario.defendingPlayers[index]);
                      },
                      removePlayer: () {
                        removePlayer(GodfatherScenario.defendingPlayers[index]);
                      },
                      disable: () =>
                          isDisable(GodfatherScenario.defendingPlayers[index]),
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
                        return MessageBox(
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
