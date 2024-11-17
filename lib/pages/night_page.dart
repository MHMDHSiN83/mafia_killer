import 'package:flutter/material.dart';
import 'package:mafia_killer/components/confirmation_box.dart';
import 'package:mafia_killer/components/mafia_choice_box.dart';
import 'package:mafia_killer/components/message_box.dart';
import 'package:mafia_killer/components/night_player_tile.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/sixth_sense_box.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/talking_page_screen_arguments.dart';
import 'package:mafia_killer/themes/app_color.dart';

class NightPage extends StatefulWidget {
  const NightPage({super.key});
  static late Player? targetPlayer;
  static int mafiaTeamChoice = 0;
  static String buttonText = 'بیدار شدند';
  static int typeOfConfirmation = 0;
  static bool ableToSelectTile = false;
  static bool isNightOver = false;

  @override
  State<NightPage> createState() => _NightPageState();
}

class _NightPageState extends State<NightPage> {
  late String text;

  late Iterator<String> iterator;

  void mafiaChoicBox() {
    showDialog(
      context: context,
      builder: (context) {
        return MafiaChoiceBox(
          shot: () {
            setState(() {
              NightPage.mafiaTeamChoice = 0;
              GodfatherScenario.setMafiaTeamAvailablePlayers();
              text = GodfatherScenario.setMafiaChoiceText();
              Navigator.of(context).pop();
            });
          },
          sixthSense: () {
            setState(() {
              NightPage.mafiaTeamChoice = 1;
              GodfatherScenario.setMafiaTeamAvailablePlayers();
              text = GodfatherScenario.setMafiaChoiceText();
              NightPage.typeOfConfirmation = 1;
              Navigator.of(context).pop();
            });
          },
          buying: () {
            setState(() {
              NightPage.mafiaTeamChoice = 2;
              GodfatherScenario.setMafiaTeamAvailablePlayers();
              text = GodfatherScenario.setMafiaChoiceText();
              NightPage.typeOfConfirmation = 2;
              Navigator.of(context).pop();
            });
          },
        );
      },
    );
  }

  void confirmAction(Player player) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationBox(
          onSave: () {
            NightPage.targetPlayer = player;

            Navigator.of(context).pop();
            setState(() {
              if (iterator.moveNext()) {
                text = iterator.current;
              }
            });
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void sixthSenseAction(Player player) {
    showDialog(
      context: context,
      builder: (context) {
        return SixthSenseBox(
          guessedRight: () {
            NightPage.targetPlayer = player;
            Navigator.of(context).pop();
            setState(() {
              if (iterator.moveNext()) {
                text = iterator.current;
              }
            });
          },
          guessedWrong: () {
            NightPage.targetPlayer = null;
            Navigator.of(context).pop();
            setState(() {
              if (iterator.moveNext()) {
                text = iterator.current;
              }
            });
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void buyingAction(Player player) {
    confirmAction(player);
  }

  void noAbilityBox(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return MessageBox(
          message: message,
          onSave: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  void initState() {
    iterator =
        GodfatherScenario.callRolesRegularNight(mafiaChoicBox, noAbilityBox)
            .iterator;
    iterator.moveNext();
    text = iterator.current;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        pageTitle: 'شب ${Scenario.currentScenario.dayAndNightNumber()}',
        rightButtonText:
            "روز ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.dayNumber)}",
        leftButtonText:
            "روز ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.dayNumber - 1)}",
        leftButtonOnTap: () {
          Scenario.currentScenario.backToLastStage();
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          if (NightPage.isNightOver) {
          Scenario.currentScenario.goToNextStage();
          Navigator.pushNamed(
            context,
            '/talking_page',
            arguments: TalkingPageScreenArguments(
              nextPagePath: '/night_page',
              seconds: GameSettings.currentGameSettings.mainSpeakTime,
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
                      return NightPlayerTile(
                        player: Player.inGamePlayers[index],
                        confirmAction: () {
                          switch (NightPage.typeOfConfirmation) {
                            case 0:
                              confirmAction(Player.inGamePlayers[index]);
                              break;
                            case 1:
                              sixthSenseAction(Player.inGamePlayers[index]);
                              break;
                            case 2:
                              buyingAction(Player.inGamePlayers[index]);

                              break;
                            default:
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          const Image(
                            image: AssetImage(
                              'lib/images/backgrounds/wood-plank.png',
                            ),
                          ),
                          Container(
                            // margin: const EdgeInsets.only(top: 7),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 368 * 191 / 1140,
                            width: 368,
                            // color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    text,
                                    style: TextStyle(
                                      color: AppColors.brownColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                if (NightPage.buttonText != '')
                                  Expanded(
                                    flex: 1,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 10),
                                        foregroundColor: AppColors.brownColor,
                                        side: const BorderSide(
                                          width: 3,
                                          color: AppColors.brownColor,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (iterator.moveNext()) {
                                            text = iterator.current;
                                            NightPage.targetPlayer = null;
                                          }
                                        });
                                      },
                                      child: Text(NightPage.buttonText),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
