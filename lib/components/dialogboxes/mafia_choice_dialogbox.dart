import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/dialogbox_template_dir/dialogbox_template.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/themes/app_color.dart';

class MafiaChoiceDialogbox extends StatelessWidget {
  const MafiaChoiceDialogbox(
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
    if ((Scenario.currentScenario as GodfatherScenario)
        .doesSaulGoodmanParticipate()) {
      return DialogboxTemplate(
          firstButtonFunction: ableToSixthSense ? sixthSense : () {},
          firstButtonText: "حس ششم",
          firstButtonColor: AppColors.redColor,
          firstButtonDisabled: !ableToSixthSense,
          secondButtonFunction: ableToBuying ? buying : () {},
          secondButtonText: "خریداری",
          secondButtonColor: AppColors.redColor,
          secondButtonDisabled: !ableToBuying,
          thirdButtonFunction: shot,
          thirdButtonText: "شلیک شب",
          thirdButtonColor: AppColors.redColor,
          child: Text(
              "تیم مافیا از بین شلیک شب و حس ششم یک گزینه را انتخاب کند."));
    } else {
      return DialogboxTemplate(
          firstButtonFunction: ableToSixthSense ? sixthSense : () {},
          firstButtonText: "حس ششم",
          firstButtonColor: AppColors.redColor,
          firstButtonDisabled: !ableToSixthSense,
          secondButtonFunction: shot,
          secondButtonText: "شلیک شب",
          secondButtonColor: AppColors.redColor,
          child: Text(
              "تیم مافیا از بین شلیک شب و حس ششم یک گزینه را انتخاب کند."));
    }
  }
}
