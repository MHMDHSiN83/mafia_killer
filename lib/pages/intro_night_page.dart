import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/intro_night_player_tile.dart';
import 'package:mafia_killer/components/nostradamus_box.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/models/talking_page_screen_arguments.dart';

class IntroNightPage extends StatefulWidget {
  const IntroNightPage({super.key});
  static List<Player> targetPlayers = [];
  static String buttonText = 'بیدار شد';
  static bool isNostradamusSelecting = true;
  static bool isNightOver = false;

  @override
  State<IntroNightPage> createState() => _IntroNightPageState();
}

class _IntroNightPageState extends State<IntroNightPage> {
  late String text;
  Map<Player, bool> playerCheckboxStatus = {};
  late Iterator<String> iterator;

  bool isCheckBoxDisable(Player player) {
    bool result = false;
    if (IntroNightPage.targetPlayers.length == 3) {
      result = true;
    }
    for (Player p in IntroNightPage.targetPlayers) {
      if (p == player) {
        result = false;
      }
    }
    return result;
  }

  void onChanged(Player player) {
    setState(() {
      bool selected = !playerCheckboxStatus[player]!;
      playerCheckboxStatus[player] = selected;
      if (selected) {
        IntroNightPage.targetPlayers.add(player);
      } else {
        IntroNightPage.targetPlayers.remove(player);
      }
    });
  }

  void nostradamusBox(int mafiaNumber) {
    showDialog(
      context: context,
      builder: (context) {
        return NostradamusBox(
          mafiaNumber: mafiaNumber,
          chooseSide: (RoleSide roleSide) {
            (Player.getPlayerByRoleType(Nostradamus).role as Nostradamus)
                .setNostradamusRole(roleSide);
            IntroNightPage.isNostradamusSelecting = false;
            Navigator.of(context).pop();
            setState(() {
              iterator.moveNext();
              text = iterator.current;
            });
          },
        );
      },
    );
  }

  void resetNight() {
    IntroNightPage.targetPlayers = [];
    IntroNightPage.buttonText = 'بیدار شد';
    IntroNightPage.isNostradamusSelecting = true;
    IntroNightPage.isNightOver = false;
    iterator = Scenario.currentScenario.callRolesIntroNight().iterator;
    iterator.moveNext();
    text = iterator.current;
    for (Player player in Player.inGamePlayers) {
      playerCheckboxStatus[player] = false;
    }
  }

  @override
  void initState() {
    iterator = Scenario.currentScenario.callRolesIntroNight().iterator;
    iterator.moveNext();
    text = iterator.current;
    for (Player player in Player.inGamePlayers) {
      playerCheckboxStatus[player] = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        label: ModalRoute.of(context)!.settings.name!,
        pageTitle: 'شب معارفه',
        rightButtonText:
            "روز ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.dayNumber)}",
        leftButtonText:
            "روز ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.dayNumber - 1)}",
        leftButtonOnTap: () {
          Scenario.currentScenario.backToLastStage();
          IntroNightPage.targetPlayers = [];
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          if (IntroNightPage.isNightOver) {
            Scenario.currentScenario.goToNextStage();
            resetNight();
            Navigator.pushNamed(
              context,
              '/talking_page',
              arguments: TalkingPageScreenArguments(
                nextPagePath: '/regular_voting_page',
                seconds: GameSettings.currentGameSettings.mainSpeakTime,
                rightButtonText: 'رای گیری',
                leftButtonText:
                    'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber - 1)}',
                isDefense: false,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Expanded(
                flex: 15,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of tiles per row
                      childAspectRatio: 1, // Width/height ratio of tiles
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: Player.inGamePlayers.length,
                    itemBuilder: (context, index) {
                      return IntroNightPlayerTile(
                        player: Player.inGamePlayers[index],
                        selected:
                            playerCheckboxStatus[Player.inGamePlayers[index]]!,
                        isCheckBoxDisable:
                            isCheckBoxDisable(Player.inGamePlayers[index]),
                        onChanged: onChanged,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: CallRole(
                  text: text,
                  onPressed: () {
                    if (IntroNightPage.targetPlayers.length == 3) {
                      //TODO build a function to generate nostradamus choice
                      if (IntroNightPage.isNostradamusSelecting) {
                        nostradamusBox(
                          (Scenario.currentScenario as GodfatherScenario).resultOfNostradamusGuess(
                              IntroNightPage.targetPlayers),
                        );
                      } else {
                        setState(() {
                          if (iterator.moveNext()) {
                            text = iterator.current;
                          }
                        });
                      }
                    }
                  },
                  buttonText: IntroNightPage.buttonText,
                ),
                // child: Container(
                //   margin: const EdgeInsets.only(top: 25),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Stack(
                //         children: [
                //           const Image(
                //             image: AssetImage(
                //               'lib/images/backgrounds/wood-plank.png',
                //             ),
                //           ),
                //           Container(
                //             padding: const EdgeInsets.symmetric(horizontal: 20),
                //             height: 368 * 191 / 1140,
                //             width: 368,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                 Expanded(
                //                   flex: 2,
                //                   child: Text(
                //                     text,
                //                     style: TextStyle(
                //                       color: AppColors.brownColor,
                //                       fontSize: 12,
                //                     ),
                //                   ),
                //                 ),
                //                 if (IntroNightPage.buttonText != '')
                //                   Expanded(
                //                     flex: 1,
                //                     child: OutlinedButton(
                //                       style: OutlinedButton.styleFrom(
                //                         padding: const EdgeInsets.symmetric(
                //                             horizontal: 0, vertical: 10),
                //                         foregroundColor: AppColors.brownColor,
                //                         side: const BorderSide(
                //                           width: 3,
                //                           color: AppColors.brownColor,
                //                         ),
                //                         shape: RoundedRectangleBorder(
                //                           borderRadius: BorderRadius.circular(
                //                             8,
                //                           ),
                //                         ),
                //                       ),
                //                       onPressed: () {
                //                         if (IntroNightPage
                //                                 .targetPlayers.length ==
                //                             3) {
                //                           //TODO build a function to generate nostradamus choice
                //                           if (IntroNightPage
                //                               .isNostradamusSelecting) {
                //                             nostradamusBox(
                //                               GodfatherScenario
                //                                   .resultOfNostradamusGuess(
                //                                       IntroNightPage
                //                                           .targetPlayers),
                //                             );
                //                           } else {
                //                             setState(() {
                //                               if (iterator.moveNext()) {
                //                                 text = iterator.current;
                //                               }
                //                             });
                //                           }
                //                         }
                //                       },
                //                       child: Text(IntroNightPage.buttonText),
                //                     ),
                //                   ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
