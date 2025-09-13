import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/dialogboxes/noon_nap_choice_dialogbox.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/mafia_nights/mafia_nights_scenario.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/utils/settings_page.dart';

class NoonNapPage extends StatefulWidget {
  const NoonNapPage({super.key});
  static int mayorChoice = 0;
  static List<Player> targetPlayers = [];
  static String buttonText = 'بیدار شدند';
  static int typeOfConfirmation = 0;
  static bool isNapOver = false;
  @override
  State<NoonNapPage> createState() => _NoonNapPageState();
}

class _NoonNapPageState extends State<NoonNapPage> {
  Map<Player, bool> playerBoxStatus = {};

  late String text;
  late Iterator<String> iterator;

  void addPlayer(Player player) {
    setState(() {
      NoonNapPage.targetPlayers.add(player);
      if (NoonNapPage.targetPlayers.length == 2) {
        NoonNapPage.targetPlayers.removeAt(0);
      }
    });
  }

  void removePlayer(Player player) {
    setState(() {
      if (NoonNapPage.targetPlayers.contains(player)) {
        NoonNapPage.targetPlayers.remove(player);
      }
    });
  }

  void mayorChoicBox() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return NoonNapChoiceDialogbox(
          nothing: () {
            AudioManager.playClickEffect();
            setState(() {
              NoonNapPage.mayorChoice = 0;
              if (iterator.moveNext()) {
                text = iterator.current;
              }
              Navigator.of(context).pop();
            });
          },
          veto: () {
            AudioManager.playClickEffect();
            setState(() {
              NoonNapPage.mayorChoice = 1;
              if (iterator.moveNext()) {
                text = iterator.current;
              }
              Navigator.of(context).pop();
            });
          },
          killPlayer: () {
            AudioManager.playClickEffect();
            setState(() {
              NoonNapPage.mayorChoice = 2;
              if (iterator.moveNext()) {
                text = iterator.current;
              }
              Navigator.of(context).pop();
            });
          },
        );
      },
    );
  }

  void resetUIBeforeNight() {
    iterator = (Scenario.currentScenario as MafiaNightsScenario)
        .noonNapAction(mayorChoiceBox: mayorChoicBox)
        .iterator;

    iterator.moveNext();
    text = iterator.current;

    NoonNapPage.targetPlayers = [];
    NoonNapPage.mayorChoice = 0;
    NoonNapPage.buttonText = 'خوابیدن';
    Scenario.currentScenario.ableToSelectTile = false;
    NoonNapPage.isNapOver = false;
    for (Player player in Player.inGamePlayers) {
      playerBoxStatus[player] = false;
    }
  }

  @override
  void initState() {
    for (Player player in Scenario.currentScenario.defendingPlayers) {
      playerBoxStatus[player] = false;
    }
    resetUIBeforeNight();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        label: '/noon_nap_page',
        pageTitle: "خواب نیم‌روزی",
        reloadContentOfPage: () {
          setState(() {});
        },
        settingsPage: () {
          return settingsPage(context, 5);
        },
        leftButtonText: "رای‌گیری دفاعیه",
        rightButtonText: 'شب ${GameStateManager.getNextStateNumber()}',
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          if (Scenario.currentScenario is GodfatherScenario) {
            (Scenario.currentScenario as GodfatherScenario)
                .resetSilencedPlayersBeforeLastMoveCardPage();
          }
          AudioManager.playNextPageEffect();
          if (!NoonNapPage.isNapOver) {
            return;
          }
          if (NoonNapPage.mayorChoice == 1) {
            Navigator.pushNamed(context, '/night_page');
          } else {
            if (Scenario.currentScenario.hasUnusedCards()) {
              Navigator.pushNamed(context, '/last_move_card_page');
            } else {
              Player.getPlayerByName(
                      Scenario.currentScenario.killedInDayPlayer!.name)
                  .playerStatus = PlayerStatus.dead;
              if (Scenario.currentScenario.isGameOver()) {
                Navigator.pushNamed(context, '/end_game_page');
              } else {
                Navigator.pushNamed(context, '/night_page');
              }
            }
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
                      isClicked: NoonNapPage.targetPlayers.contains(
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                child: CallRole(
                  text: text,
                  buttonText: NoonNapPage.buttonText,
                  onPressed: () {
                    AudioManager.playClickEffect();
                    setState(() {
                      if (NoonNapPage.buttonText != 'تائید' ||
                          Scenario.currentScenario.currentPlayerAtNight!.role!
                              .hasAllSelected(
                                  NoonNapPage.targetPlayers.length)) {
                        if (iterator.moveNext()) {
                          text = iterator.current;
                          NoonNapPage.targetPlayers = [];
                          for (Player player in Player.inGamePlayers) {
                            playerBoxStatus[player] = false;
                          }
                        }
                      }
                    });
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
