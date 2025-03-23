import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/themes/app_color.dart';

class MafiaChoiceBox extends StatelessWidget {
  const MafiaChoiceBox(
      {super.key,
      required this.shot,
      required this.buying,
      required this.sixthSense});

  final VoidCallback shot;
  final VoidCallback buying;
  final VoidCallback sixthSense;

  @override
  Widget build(BuildContext context) {
    bool ableToSixthSense =
        (Scenario.currentScenario as GodfatherScenario).ableToSixthSense();
    bool ableToBuying =
        (Scenario.currentScenario as GodfatherScenario).ableToBuying();
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 10,
      content: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/dialogbox/DialogBoxBg.png'),
                fit: BoxFit.cover)),
        height: 240,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: shot,
              color: AppColors.brownColor,
              child: Text(
                "شلیک شب",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Opacity(
              opacity: ableToSixthSense ? 1 : 0.6,
              child: MaterialButton(
                onPressed: ableToSixthSense ? sixthSense : () {},
                color: AppColors.brownColor,
                child: Text(
                  "حس ششم",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if ((Scenario.currentScenario as GodfatherScenario)
                .doesSaulGoodmanParticipate())
              Opacity(
                opacity: ableToBuying ? 1 : 0.6,
                child: MaterialButton(
                  onPressed: ableToBuying ? buying : () {},
                  color: AppColors.brownColor,
                  child: Text(
                    "خریداری",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
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
