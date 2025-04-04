import 'package:flutter/material.dart';
import 'package:mafia_killer/components/last_move_card_guide_tile.dart';
import 'package:mafia_killer/components/role_guide_tile.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/databases/scenario_guide.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/themes/app_color.dart';

class ScenarioGuidPage extends StatelessWidget {
  ScenarioGuidPage({super.key});

  //TODO all the things in this page are for godfather scenario

  Scenario selectedScenario = Scenario.scenarios.first;
  List<Widget> roleDescriptions() {
    List<Widget> result = [];
    for (Role role in selectedScenario.roles) {
      result.add(RoleGuideTile(role: role));
    }
    return result;
  }

  List<Widget> lastMoveCardsDescriptions() {
    List<Widget> result = [];
    for (LastMoveCard lastMoveCard in selectedScenario.lastMoveCards) {
      result.add(LastMoveCardGuideTile(lastMoveCard: lastMoveCard));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "lib/images/backgrounds/background-image-edited.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 60,
                          color: AppColors.redColor,
                        )),
                  ),
                ],
              ),
              Expanded(
                flex: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "سناریو    ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          decoration: TextDecoration.none,
                          fontFamily: 'DigiGaf',
                          fontSize: 75),
                    ),
                    Text(
                      "پدرخوانده",
                      style: TextStyle(
                          color: AppColors.redColor,
                          decoration: TextDecoration.none,
                          fontFamily: 'DigiGaf',
                          fontSize: 75),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 40,
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'lib/images/backgrounds/ScenarioGuidTextBg.png'),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          "قوانین و توضیحات سناریو",
                          style: const TextStyle(fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 34,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: ListView(children: [
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      ScenarioGuide
                                          .scenarioGuides!["پدرخوانده"]!,
                                      style: const TextStyle(fontSize: 15),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 25, 8, 8),
                                    child: Text(
                                      "نقش‌های بازی",
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                                Divider(),
                                ...roleDescriptions(),
                                if (selectedScenario.lastMoveCards.isNotEmpty)
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 25, 8, 8),
                                      child: Text(
                                        "کارت های حرکت آخر",
                                        style: const TextStyle(fontSize: 20),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                if (selectedScenario.lastMoveCards.isNotEmpty)
                                  Divider(),
                                ...lastMoveCardsDescriptions()
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(
                flex: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
