import 'package:flutter/material.dart';
import 'package:mafia_killer/components/inquiry_dialog.dart';
import 'package:mafia_killer/components/night_event_tile.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/godfather.dart';
import 'package:mafia_killer/models/talking_page_screen_arguments.dart';
import 'package:mafia_killer/themes/app_color.dart';

class NightEventsPage extends StatefulWidget {
  const NightEventsPage({super.key});

  @override
  State<NightEventsPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<NightEventsPage> {
  late double width;
  late double height;
  void calculateSizeOfImage() {
    width = MediaQuery.of(context).size.width;
    height = 406 * width / 329;
  }

  void showInquiryDialog(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return InquiryDialog(
          child: Column(
            children: [
              Text(
                '${GodfatherScenario.numberOfDeadPlayersBySide(RoleSide.citizen)} شهروند',
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
                '${GodfatherScenario.numberOfDeadPlayersBySide(RoleSide.mafia)} مافیا',
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
                '${GodfatherScenario.numberOfDeadPlayersBySide(RoleSide.independant)} نوستراداموس',
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
  }

  @override
  Widget build(BuildContext context) {
    calculateSizeOfImage();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageFrame(
        pageTitle: "اتفاقات شب",
        leftButtonText: "قبلی",
        rightButtonText: "رای گیری",
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
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
        },
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
                      image: AssetImage('lib/images/backgrounds/letter.png'),
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
                              itemCount: GodfatherScenario.report.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: NightEventTile(
                                  text: GodfatherScenario.report[index],
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
    );
  }
}
