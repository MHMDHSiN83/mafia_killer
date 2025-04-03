import 'package:flutter/material.dart';
import 'package:mafia_killer/themes/app_color.dart';

class ScenarioGuidPage extends StatelessWidget {
  const ScenarioGuidPage({super.key});

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
                                  child: Text(
                                    "",
                                    style: const TextStyle(fontSize: 15),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
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
