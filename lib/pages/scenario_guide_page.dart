import 'package:flutter/material.dart';
import 'package:mafia_killer/components/last_move_card_guide_tile.dart';
import 'package:mafia_killer/components/role_guide_tile.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/databases/scenario_guide.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/themes/app_color.dart';

class ScenarioGuidPage extends StatelessWidget {
  const ScenarioGuidPage({super.key});

  //TODO: all the things in this page are for godfather scenario

  List<Widget> roleDescriptions(Scenario scenario) {
    List<Widget> result = [];
    for (Role role in scenario.roles) {
      result.add(RoleGuideTile(role: role));
    }
    return result;
  }

  List<Widget> lastMoveCardsDescriptions(Scenario scenario) {
    List<Widget> result = [];
    for (LastMoveCard lastMoveCard in scenario.lastMoveCards) {
      result.add(LastMoveCardGuideTile(lastMoveCard: lastMoveCard));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    for (String scenarioName in Scenario.getScenarioNames())
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "سناریو    ",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'DigiGaf',
                                  fontSize: 26),
                            ),
                            Text(
                              scenarioName,
                              style: TextStyle(
                                  color: AppColors.redColor,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'DigiGaf',
                                  fontSize: 26),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 30,
                  child: TabBarView(
                    children: [
                      for (Scenario scenario in Scenario.scenarios)
                        Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'lib/images/backgrounds/ScenarioGuidTextBg.png'),
                                fit: BoxFit.cover),
                          ),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: ListView(
                                      primary: false,
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                              ScenarioGuide.scenarioGuides![
                                                  scenario.name]!,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                height: 1.6,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ),
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 25, 8, 8),
                                            child: Text(
                                              "نقش‌های بازی",
                                              style:
                                                  const TextStyle(fontSize: 20),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                        ...roleDescriptions(scenario),
                                        if (scenario.lastMoveCards.isNotEmpty)
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 25, 8, 8),
                                              child: Text(
                                                "کارت های حرکت آخر",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ),
                                        if (scenario.lastMoveCards.isNotEmpty)
                                          Divider(),
                                        ...lastMoveCardsDescriptions(scenario)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
