import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/confirmation_box.dart';
import 'package:mafia_killer/components/mafia_choice_box.dart';
import 'package:mafia_killer/components/message_box.dart';
import 'package:mafia_killer/components/night_player_tile.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/sixth_sense_box.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/ui_player_status.dart';
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

class _NightPageState extends State<NightPage> {
  late String text;

  late Iterator<String> iterator;

  void mafiaChoicBox() {
    showDialog(
      context: context,
      builder: (context) {
        return MafiaChoiceBox(
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
        return ConfirmationBox(
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
    Player.inGamePlayers = GameStateManager
        .gameStates[GameStateManager.getPreviousState()]!.players;
    if (Scenario.currentScenario is GodfatherScenario) {
      iterator = Scenario.currentScenario
          .callRolesRegularNight(
              mafiaChoiceBox: mafiaChoicBox, noAbilityBox: noAbilityBox)
          .iterator;
    } else {
      UnimplementedError("error");
    }
    iterator.moveNext();
    text = iterator.current;
    NightPage.targetPlayer = null;
    NightPage.mafiaTeamChoice = 0;
    NightPage.buttonText = 'بیدار شدند';
    NightPage.typeOfConfirmation = 0;
    NightPage.ableToSelectTile = false;
    NightPage.isNightOver = false;
    Scenario.currentScenario.nightEvents = {};
    resetTiles();
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

  @override
  void initState() {
    GameStateManager.addState(
        lastMoveCards: Scenario.currentScenario.lastMoveCards,
        silencedPlayerDuringDay:
            Scenario.currentScenario.silencedPlayerDuringDay);
    Logger().d(GameStateManager.gameStates);
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        label: '/night_page',
        pageTitle: 'شب ${Scenario.currentScenario.dayAndNightNumber()}',
        reloadContentOfPage: () {
          setState(() {});
        },
        rightButtonText: 'اتفاقات شب',
        leftButtonText:
            "روز ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.dayNumber - 1)}",
        leftButtonOnTap: () {
          Scenario.currentScenario.backToLastStage();
          GameStateManager.goToPreviousState();
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          if (NightPage.isNightOver) {
            iterator.moveNext();
            Scenario.currentScenario.goToNextStage();
            // resetNight();
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
                flex: 2,
                child: IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    size: 35,
                  ),
                  color: const Color(0xFFE01357),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmationBox(
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
                ),
              ),
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
