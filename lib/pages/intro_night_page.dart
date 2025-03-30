import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/dialogboxes/confirmation_dialogbox.dart';
import 'package:mafia_killer/components/intro_night_player_tile.dart';
import 'package:mafia_killer/components/dialogboxes/nostradamus_dialogbox.dart';
import 'package:mafia_killer/components/my_divider.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/models/talking_page_screen_arguments.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';

class IntroNightPage extends StatefulWidget {
  const IntroNightPage({super.key});
  static List<Player> targetPlayers = [];
  static String buttonText = 'بیدار شد';
  static bool isNostradamusSelecting =
      (Scenario.currentScenario as GodfatherScenario)
          .doesNostradamusParticipate();
  static bool isNightOver = false;

  @override
  State<IntroNightPage> createState() => _IntroNightPageState();
}

class _IntroNightPageState extends State<IntroNightPage> {
  late String text;
  Map<Player, bool> playerCheckboxStatus = {};
  late Iterator<String> iterator;
  Map<String, dynamic> gameSettings =
      GameSettings.currentGameSettings.getSettingsInMap();

  bool isCheckBoxDisable(Player player) {
    bool result = false;
    if ((Scenario.currentScenario as GodfatherScenario)
            .doesNostradamusParticipate() &&
        (IntroNightPage.targetPlayers.length ==
            (Player.getPlayerByRoleType(Nostradamus)!.role as Nostradamus)
                .inquiryNumber)) {
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
        return NostradamusDialogbox(
          mafiaNumber: mafiaNumber,
          chooseSide: (RoleSide roleSide) {
            (Player.getPlayerByRoleType(Nostradamus)!.role as Nostradamus)
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
    IntroNightPage.isNostradamusSelecting =
        (Scenario.currentScenario as GodfatherScenario)
            .doesNostradamusParticipate();
    IntroNightPage.isNightOver = false;
    iterator = Scenario.currentScenario.callRolesIntroNight().iterator;
    iterator.moveNext();
    text = iterator.current;
    for (Player player in Player.inGamePlayers) {
      playerCheckboxStatus[player] = false;
    }
  }

  Widget? settingsPage() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'شروع مجدد شب معارفه',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            IconButton(
              onPressed: () {
                AudioManager.playClickEffect();
                setState(() {
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmationDialogbox(
                      onSave: () {
                        AudioManager.playClickEffect();
                        setState(() {
                          resetNight();
                        });
                        Navigator.pop(context);
                      },
                      onCancel: () {
                        AudioManager.playClickEffect();
                        Navigator.pop(context);
                      },
                    ),
                  );
                });
              },
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.refresh,
                size: 40,
                color: AppColors.redColor,
              ),
            ),
          ],
        ),
        MyDivider(),
      ],
    );
  }

  @override
  void initState() {
    resetNight();
    AudioManager.playNightMusic();
    super.initState();
  }

  @override
  void dispose() {
    AudioManager.stopMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        label: '/intro_night_page',
        pageTitle: 'شب معارفه',
        reloadContentOfPage: () {
          setState(() {});
        },
        settingsPage: settingsPage,
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
            // resetNight();
            AudioManager.playNextPageEffect();
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
            GameStateManager.addState(
                lastMoveCards: Scenario.currentScenario.lastMoveCards);
          } else {
            customSnackBar(context, 'تمام اکت‌های شب باید انجام بشه', true);
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
                    AudioManager.playClickEffect();
                    // if (IntroNightPage.targetPlayers.length == 3) {
                    //   //TODO build a function to generate nostradamus choice
                    //   if (IntroNightPage.isNostradamusSelecting) {
                    //     nostradamusBox(
                    //       (Scenario.currentScenario as GodfatherScenario)
                    //           .resultOfNostradamusGuess(
                    //               IntroNightPage.targetPlayers),
                    //     );
                    //   } else {
                    //     setState(() {
                    //       if (iterator.moveNext()) {
                    //         text = iterator.current;
                    //       }
                    //     });
                    //   }
                    // }
                    if (IntroNightPage.isNostradamusSelecting) {
                      if (IntroNightPage.targetPlayers.length ==
                          (Player.getPlayerByRoleType(Nostradamus)!.role
                                  as Nostradamus)
                              .inquiryNumber) {
                        nostradamusBox(
                          (Scenario.currentScenario as GodfatherScenario)
                              .resultOfNostradamusGuess(
                                  IntroNightPage.targetPlayers),
                        );
                      }
                    } else {
                      setState(() {
                        if (iterator.moveNext()) {
                          text = iterator.current;
                        }
                      });
                    }
                  },
                  buttonText: IntroNightPage.buttonText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
