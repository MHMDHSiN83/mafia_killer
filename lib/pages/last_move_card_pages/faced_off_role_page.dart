import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/pages/last_move_card_page.dart';
import 'package:mafia_killer/pages/last_move_card_pages/face_off_page.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/utils/settings_page.dart';

class FacedOffRolePage extends StatelessWidget {
  const FacedOffRolePage({super.key});

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
          label: '/faced_off_role_page',
          pageTitle: "نقش جدید",
          settingsPage: () {
            if (LastMoveCardPage.selectedLastMoveCard != null) {
              LastMoveCardPage.selectedLastMoveCard!.isUsed = false;
            }
            return settingsPage(context, 8);
          },
          leftButtonText: "کارت حرکت آخر",
          rightButtonText:
              'شب ${GameStateManager.getNextStateNumber()}',
          leftButtonOnTap: () => Navigator.pop(context),
          rightButtonOnTap: () {
            GameStateManager.addLastMoveCardAction([
              Scenario.currentScenario.killedInDayPlayer!,
              FaceOffPage.selectedPlayers[0]
            ], LastMoveCardPage.selectedLastMoveCard!);
            LastMoveCardPage.selectedLastMoveCard!.lastMoveCardAction([
              Player.getPlayerByName(
                  Scenario.currentScenario.killedInDayPlayer!.name),
              Player.getPlayerByName(FaceOffPage.selectedPlayers[0].name),
            ]);

            if (Scenario.currentScenario.isGameOver()) {
              AudioManager.playNextPageEffect();
              Navigator.pushNamed(context, '/end_game_page');
            } else {
              AudioManager.playNextPageEffect();
              Navigator.pushNamed(context, '/night_page');
            }
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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                    child: CallRole(
                        text:
                            "${FaceOffPage.selectedPlayers[0].name} را بیدار کن و نقش جدیدشو بهش نشون بده",
                        onPressed: () {},
                        buttonText: ""),
                  ))
            ],
          ),
        ));
  }
}
