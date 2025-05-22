import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/dialogboxes/confirmation_dialogbox.dart';
import 'package:mafia_killer/components/dialogboxes/mafia_choice_dialogbox.dart';
import 'package:mafia_killer/components/dialogboxes/message_dialogbox.dart';
import 'package:mafia_killer/components/my_divider.dart';
import 'package:mafia_killer/components/night_player_tile.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/dialogboxes/sixth_sense_dialogbox.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';

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

class _NightPageState extends State<NightPage> with WidgetsBindingObserver {
  late String text;

  late Iterator<String> iterator;

  void mafiaChoicBox() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return MafiaChoiceDialogbox(
          shot: () {
            AudioManager.playClickEffect();
            setState(() {
              NightPage.mafiaTeamChoice = 0;
              (Scenario.currentScenario as GodfatherScenario)
                  .setMafiaTeamAvailablePlayers();
              text = (Scenario.currentScenario as GodfatherScenario)
                  .setMafiaChoiceText();
              Navigator.of(context).pop();
            });
          },
          sixthSense: () {
            AudioManager.playClickEffect();
            setState(() {
              NightPage.mafiaTeamChoice = 1;
              (Scenario.currentScenario as GodfatherScenario)
                  .setMafiaTeamAvailablePlayers();
              text = (Scenario.currentScenario as GodfatherScenario)
                  .setMafiaChoiceText();
              NightPage.typeOfConfirmation = 1;
              Navigator.of(context).pop();
            });
          },
          buying: () {
            AudioManager.playClickEffect();
            setState(() {
              NightPage.mafiaTeamChoice = 2;
              (Scenario.currentScenario as GodfatherScenario)
                  .setMafiaTeamAvailablePlayers();
              text = (Scenario.currentScenario as GodfatherScenario)
                  .setMafiaChoiceText();
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
        return ConfirmationDialogbox(
          onSave: () {
            AudioManager.playClickEffect();
            NightPage.targetPlayer = player;
            Navigator.of(context).pop();
            setState(() {
              if (iterator.moveNext()) {
                text = iterator.current;
              }
            });
          },
          onCancel: () {
            AudioManager.playClickEffect();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void sixthSenseAction(Player player) {
    showDialog(
      context: context,
      builder: (context) {
        return SixthSenseDialogbox(
          player: player,
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
        return MessageDialogbox(
          message: message,
          onSave: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void resetUIBeforeNight() {
    if (Scenario.currentScenario is GodfatherScenario) {
      iterator = Scenario.currentScenario
          .callRolesRegularNight(
              mafiaChoiceBox: mafiaChoicBox, noAbilityBox: noAbilityBox)
          .iterator;
    } else {
      UnimplementedError("error");
    }
    resetTiles();
    iterator.moveNext();
    text = iterator.current;

    NightPage.targetPlayer = null;
    NightPage.mafiaTeamChoice = 0;
    NightPage.buttonText = 'بیدار شدند';
    NightPage.typeOfConfirmation = 0;
    NightPage.ableToSelectTile = false;
    NightPage.isNightOver = false;
    Scenario.currentScenario.nightEvents = {};
    Scenario.currentScenario.report = [];
  }

  void resetNight() {
    // Scenario.currentScenario.resetRemainingAbility();
    // if (Scenario.currentScenario is GodfatherScenario) {
    //   iterator = Scenario.currentScenario
    //       .callRolesRegularNight(
    //           mafiaChoiceBox: mafiaChoicBox, noAbilityBox: noAbilityBox)
    //       .iterator;
    // } else {
    //   UnimplementedError("error");
    // }
    // iterator.moveNext();
    // text = iterator.current;
    // NightPage.targetPlayer = null;
    // NightPage.mafiaTeamChoice = 0;
    // NightPage.buttonText = 'بیدار شدند';
    // NightPage.typeOfConfirmation = 0;
    // NightPage.ableToSelectTile = false;
    // NightPage.isNightOver = false;
    // Scenario.currentScenario.nightEvents = {};
    // resetTiles();
    // Scenario.currentScenario.resetDataAfterNight();
    // Scenario.currentScenario.resetRemainingAbility();

    Player.inGamePlayers = Player.copyList(GameStateManager
        .gameStates[GameStateManager.getPreviousState()]!.players);

    resetUIBeforeNight();
  }

  void resetTiles() {
    for (Player player in Player.inGamePlayers) {
      if (player.playerStatus == PlayerStatus.removed ||
          player.playerStatus == PlayerStatus.dead) {
        player.uiPlayerStatus = UIPlayerStatus.untargetable;
      } else {
        player.uiPlayerStatus = UIPlayerStatus.targetable;
      }
    }
  }

  Widget? settingsPage() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'شروع مجدد شب ${GameStateManager.getCurrentStateNumber()}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            IconButton(
              onPressed: () {
                AudioManager.playClickEffect();
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
    GameStateManager.addState(
        // lastMoveCards: Scenario.currentScenario.lastMoveCards,
        lastMoveCards: Scenario.currentScenario.inGameLastMoveCards,
        silencedPlayerDuringDay:
            Scenario.currentScenario.silencedPlayerDuringDay);
    Scenario.currentScenario.killedInDayPlayer = null;

    resetUIBeforeNight();

    super.initState();

    WidgetsBinding.instance.addObserver(this);
    AudioManager.playNightMusic();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      AudioManager.pauseMusic();
    } else if (state == AppLifecycleState.resumed) {
      AudioManager.resumeMusic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        label: '/night_page',
        pageTitle: 'شب ${GameStateManager.getCurrentStateNumber()}',
        reloadContentOfPage: () {
          setState(() {});
        },
        settingsPage: settingsPage,
        rightButtonText: 'اتفاقات شب',
        leftButtonText:
            "روز ${GameStateManager.getPreviousStateNumber()}",
        leftButtonOnTap: () {
          resetNight();
          GameStateManager.goToPreviousState();
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          if (NightPage.isNightOver) {
            AudioManager.stopMusic();
            AudioManager.resetMusicPlayer();
            iterator.moveNext();
            AudioManager.playNextPageEffect();
            Navigator.pushNamed(context, '/night_events_page');
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
                child: CallRole(
                  text: text,
                  buttonText: NightPage.buttonText,
                  onPressed: () {
                    AudioManager.playClickEffect();
                    setState(() {
                      if (iterator.moveNext()) {
                        text = iterator.current;
                        NightPage.targetPlayer = null;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
