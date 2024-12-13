import 'package:flutter/material.dart';
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
    bool ableToSixthSense = GodfatherScenario.ableToSixthSense();
    bool ableToBuying = GodfatherScenario.ableToBuying();
    print(ableToBuying);
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 10,
      content: SizedBox(
        height: 160,
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: shot,
              color: AppColors.darkgreenColor,
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
                color: AppColors.redColor,
                child: Text(
                  "حس ششم",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (GodfatherScenario.doesSaulGoodmanParticipate())
              Opacity(
                opacity: ableToBuying ? 1 : 0.6,
                child: MaterialButton(
                  onPressed: ableToBuying ? buying : () {},
                  color: AppColors.redColor,
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
