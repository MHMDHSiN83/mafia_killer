import 'package:flutter/material.dart';
import 'package:mafia_killer/components/inquiry_dialog.dart';
import 'package:mafia_killer/components/night_event_tile.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/talking_page_screen_arguments.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';

class NightEventsPage extends StatefulWidget {
  const NightEventsPage({super.key});

  @override
  State<NightEventsPage> createState() => _NightEventsPage();
}

class _NightEventsPage extends State<NightEventsPage> {
  late double width;
  late double height;
  bool doesPressInquiry = false;
  void calculateSizeOfImage() {
    width = MediaQuery.of(context).size.width;
    height = 406 * width / 329;
  }

  void showInquiryDialog(context) {
    if (GameSettings.currentGameSettings.inquiry == 0 && !doesPressInquiry) {
      return;
    }

    // if nostradamus is out of the game then the beautiful mind should be shown

    if (Scenario.currentScenario
            .numberOfDeadPlayersBySide(RoleSide.independant) >
        0) {
      (Scenario.currentScenario as GodfatherScenario).nostradamusRevealed();
    }

    setState(() {
      if (!doesPressInquiry) {
        GameSettings.currentGameSettings.inquiry--;
        doesPressInquiry = true;
      }
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return InquiryDialog(
            child: Column(
              children: [
                Text(
                  '${Scenario.currentScenario.numberOfDeadPlayersBySide(RoleSide.citizen)} شهروند',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${Scenario.currentScenario.numberOfDeadPlayersBySide(RoleSide.mafia)} مافیا',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${Scenario.currentScenario.numberOfDeadPlayersBySide(RoleSide.independant)} نوستراداموس',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'از بازی خارج شدند.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    calculateSizeOfImage();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageFrame(
        label: '/night_events_page',
        pageTitle: "اتفاقات شب",
        leftButtonText:
            "شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber - 1)}",
        rightButtonText:
            "روز ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.dayNumber)}",
        leftButtonOnTap: () {
          if(doesPressInquiry) {
            GameSettings.currentGameSettings.inquiry += 1;
          }
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          GameStateManager.addState(
              lastMoveCards: Scenario.currentScenario.lastMoveCards,
              silencedPlayerDuringDay:
                  Scenario.currentScenario.silencedPlayerDuringDay,
              nightReport: Scenario.currentScenario.report);
          Scenario.currentScenario.resetDataAfterNight();
          if (Scenario.currentScenario.isGameOver()) {
            AudioManager.playNextPageEffect();
            Navigator.pushNamed(context, '/end_game_page');
          } else {
            AudioManager.playNextPageEffect();
            Navigator.pushNamed(
              context,
              '/talking_page',
              arguments: TalkingPageScreenArguments(
                nextPagePath: '/regular_voting_page',
                seconds: GameSettings.currentGameSettings.mainSpeakTime,
                leftButtonText:
                    'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber - 1)}',
                rightButtonText: 'رای گیری',
                isDefense: false,
              ),
            );
          }
        },
        child: Column(
          children: [
            Text(
              "تعداد استعلام های باقیمانده: ${Language.toPersian(GameSettings.currentGameSettings.inquiry.toString())}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        width: width,
                        height: height,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('lib/images/backgrounds/letter.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 190 / 329 * width,
                            child: Column(
                              children: [
                                const Spacer(
                                  flex: 4,
                                ),
                                Expanded(
                                  flex: 12,
                                  child: ListView.builder(
                                    itemCount:
                                        Scenario.currentScenario.report.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: NightEventTile(
                                        text: Scenario
                                            .currentScenario.report[index],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showInquiryDialog(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.brownColor,
                                      elevation: 12.0,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 0),
                                      child: Text(
                                        'استعلام وضعیت',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
