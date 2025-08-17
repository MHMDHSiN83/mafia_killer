import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/last_move_card_tile.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/final_shot.dart';
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/great_lie.dart';
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/green_mile.dart';
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/insomnia.dart';
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/red_carpet.dart';
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/vertigo.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/beautiful_mind.dart'
    as godfather;
import 'package:mafia_killer/models/scenarios/classic/last_move_cards/beautiful_mind.dart'
    as classic;
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/face_off.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/handcuffs.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/reveal_identity.dart';
import 'package:mafia_killer/models/scenarios/godfather/last_move_cards/silence_of_the_lambs.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';
import 'package:mafia_killer/models/talking_page_screen_arguments.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/utils/settings_page.dart';

class LastMoveCardPage extends StatefulWidget {
  const LastMoveCardPage({super.key});
  static bool canClick = true;
  static LastMoveCard? selectedLastMoveCard;

  @override
  State<LastMoveCardPage> createState() => _LastMoveCardPageState();
}

class _LastMoveCardPageState extends State<LastMoveCardPage> {
  @override
  void initState() {
    super.initState();
    LastMoveCardPage.canClick = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        label: '/last_move_card_page',
        pageTitle: "کارت حرکت آخر",
        leftButtonText: "قبلی",
        rightButtonText: "بعدی",
        settingsPage: () {
          if (LastMoveCardPage.selectedLastMoveCard != null) {
            LastMoveCardPage.selectedLastMoveCard!.isUsed = false;
          }
          return settingsPage(context, 6);
        },
        leftButtonOnTap: () {
          LastMoveCardPage.selectedLastMoveCard?.isUsed = false;
          if (Scenario.currentScenario is GodfatherScenario) {
            Scenario.currentScenario.inGameLastMoveCards.shuffle();
          }
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          if (LastMoveCardPage.selectedLastMoveCard == null) {
            customSnackBar(context, "یک کارت باید انتخاب بشه.", true);
            return;
          }
          LastMoveCardPage.selectedLastMoveCard!.isUsed = true;
          AudioManager.playNextPageEffect();
          if (LastMoveCardPage.selectedLastMoveCard is RevealIdentity) {
            if (Scenario.currentScenario.killedInDayPlayer!.role!
                is Nostradamus) {
              (Scenario.currentScenario as GodfatherScenario)
                  .nostradamusRevealed();
            }
            Navigator.pushNamed(context, '/reveal_identity_page');
          } else if (LastMoveCardPage.selectedLastMoveCard is FaceOff) {
            Navigator.pushNamed(context, '/face_off_page');
          } else if (LastMoveCardPage.selectedLastMoveCard is Handcuffs) {
            Navigator.pushNamed(context, '/handcuffs_page');
          } else if (LastMoveCardPage.selectedLastMoveCard
              is SilenceOfTheLambs) {
            Navigator.pushNamed(context, '/silence_of_the_lambs_page');
          } else if (LastMoveCardPage.selectedLastMoveCard
              is godfather.BeautifulMind) {
            Navigator.pushNamed(
                context, '/beautiful_mind_choose_nostradamus_page');
          } else if (LastMoveCardPage.selectedLastMoveCard
              is Insomnia) {
            GameStateManager.addState(
                lastMoveCards: Scenario.currentScenario.inGameLastMoveCards,
                silencedPlayerDuringDay:
                    Scenario.currentScenario.silencedPlayerDuringDay);
            GameStateManager.addLastMoveCardAction(
                [Scenario.currentScenario.killedInDayPlayer!], LastMoveCardPage.selectedLastMoveCard!);
            LastMoveCardPage.selectedLastMoveCard!.lastMoveCardAction([Scenario.currentScenario.killedInDayPlayer!]);
            Navigator.pushNamed(
              context,
              '/talking_page',
              arguments: TalkingPageScreenArguments(
                nextPagePath: '/regular_voting_page',
                seconds: GameSettings.currentGameSettings.mainSpeakTime,
                leftButtonText:
                    'روز ${GameStateManager.getPreviousStateNumber()}',
                rightButtonText: 'رای گیری',
                isDefense: false,
              ),
            );
          } else if (LastMoveCardPage.selectedLastMoveCard is FinalShot) {
          } else if (LastMoveCardPage.selectedLastMoveCard is GreatLie) {
          } else if (LastMoveCardPage.selectedLastMoveCard is GreenMile) {
          } else if (LastMoveCardPage.selectedLastMoveCard is classic.BeautifulMind) {
            Navigator.pushNamed(
                context, '/beautiful_mind_choose_role_page');
          } else if (LastMoveCardPage.selectedLastMoveCard is RedCarpet) {
          } else if (LastMoveCardPage.selectedLastMoveCard is Vertigo) {}
        },
        isInGame: true,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemCount:
                      Scenario.currentScenario.inGameLastMoveCards.length,
                  itemBuilder: (context, index) {
                    return LastMoveCardTile(
                      lastMoveCard:
                          Scenario.currentScenario.inGameLastMoveCards[index],
                      index: index,
                    );
                  }),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CallRole(
                  text:
                      "${Scenario.currentScenario.killedInDayPlayer!.name} کشته امروز است و باید کارت حرکت آخر انتخاب کند",
                  buttonText: "",
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
