import 'package:flutter/material.dart';
import 'package:mafia_killer/components/confirmation_box.dart';
import 'package:mafia_killer/components/intro_night_player_tile.dart';
import 'package:mafia_killer/components/mafia_choice_box.dart';
import 'package:mafia_killer/components/message_box.dart';
import 'package:mafia_killer/components/night_player_tile.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/sixth_sense_box.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/themes/app_color.dart';

class IntroNightPage extends StatefulWidget {
  const IntroNightPage({super.key});
  static List<Player> targetPlayers = [];
  static int mafiaTeamChoice = 0;
  static String buttonText = 'بیدار شد';
  static int typeOfConfirmation = 0;
  static bool ableToSelectTile = true;
  static bool isNostradamusSelecting = true;

  @override
  State<IntroNightPage> createState() => _IntroNightPageState();
}

class _IntroNightPageState extends State<IntroNightPage> {
  late String text;

  late Iterator<String> iterator;

  void mafiaChoicBox() {
    showDialog(
      context: context,
      builder: (context) {
        return MafiaChoiceBox(
          shot: () {
            setState(() {
              IntroNightPage.mafiaTeamChoice = 0;
              GodfatherScenario.setMafiaTeamAvailablePlayers();
              text = GodfatherScenario.setMafiaChoiceText();
              Navigator.of(context).pop();
            });
          },
          sixthSense: () {
            setState(() {
              IntroNightPage.mafiaTeamChoice = 1;
              GodfatherScenario.setMafiaTeamAvailablePlayers();
              text = GodfatherScenario.setMafiaChoiceText();
              IntroNightPage.typeOfConfirmation = 1;
              Navigator.of(context).pop();
            });
          },
          buying: () {
            setState(() {
              IntroNightPage.mafiaTeamChoice = 2;
              GodfatherScenario.setMafiaTeamAvailablePlayers();
              text = GodfatherScenario.setMafiaChoiceText();
              IntroNightPage.typeOfConfirmation = 2;
              Navigator.of(context).pop();
            });
          },
        );
      },
    );
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
    iterator = GodfatherScenario.callRolesIntroNight().iterator;
    iterator.moveNext();
    text = iterator.current;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        pageTitle: 'شب معارفه',
        rightButtonText: "بعدی",
        leftButtonText: "قبلی",
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () =>
            Navigator.pushNamed(context, '/role_selection_page'),
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
                        confirmAction: () {},
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
                                if (IntroNightPage.buttonText != '')
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
                                        if (IntroNightPage.targetPlayers.length == 3) {
                                          if(!IntroNightPage.isNostradamusSelecting) {
                                            
                                          }
                                          setState(() {
                                            if (iterator.moveNext()) {
                                              text = iterator.current;
                                            }
                                          });
                                        }
                                      },
                                      child: Text(IntroNightPage.buttonText),
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
