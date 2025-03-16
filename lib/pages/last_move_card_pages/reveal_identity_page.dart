import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/pages/last_move_card_page.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';

class RevealIdentityPage extends StatelessWidget {
  const RevealIdentityPage({super.key});

  Color determineRoleCardBorderColor() {
    Role role = Scenario.currentScenario.killedInDayPlayer!.role!;

    if (role.roleSide == RoleSide.citizen) {
      return AppColors.darkgreenColor;
    } else if (role.roleSide == RoleSide.mafia) {
      return AppColors.redColor;
    } else {
      return AppColors.yellowColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: PageFrame(
          label: ModalRoute.of(context)!.settings.name!,
          pageTitle: "افشای هویت",
          leftButtonText: "کارت حرکت آخر",
          rightButtonText:
              'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
          leftButtonOnTap: () => Navigator.pop(context),
          rightButtonOnTap: () {
            LastMoveCardPage.selectedLastMoveCard!.lastMoveCardAction(
                [Scenario.currentScenario.killedInDayPlayer!]);
            AudioManager().playNextPageEffect();
            Navigator.pushNamed(context, '/night_page');
          },
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(
                              5), // Circular border radius
                          border: Border.all(
                            color:
                                determineRoleCardBorderColor(), // Optional: Border color
                            width: 2, // Optional: Border width
                          ),
                          image: DecorationImage(
                              image: AssetImage(Scenario.currentScenario
                                  .killedInDayPlayer!.role!.cardImagePath),
                              fit: BoxFit.contain)),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CallRole(
                        text:
                            "${Scenario.currentScenario.killedInDayPlayer!.name} ${Scenario.currentScenario.killedInDayPlayer!.role!.name} بود.",
                        onPressed: () {},
                        buttonText: ""),
                  ))
            ],
          ),
        ));
  }
}
