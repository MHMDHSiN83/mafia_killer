import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/game_state_manager.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/pages/last_move_card_page.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/utils/settings_page.dart';

class GreatLiePage extends StatelessWidget {
  const GreatLiePage({super.key});

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
          label: '/great_lie_page',
          pageTitle: "دروغ بزرگ",
          settingsPage: () {
            if (LastMoveCardPage.selectedLastMoveCard != null) {
              LastMoveCardPage.selectedLastMoveCard!.isUsed = false;
            }
            return settingsPage(context, 7);
          },
          leftButtonText: "کارت حرکت آخر",
          rightButtonText: 'شب ${GameStateManager.getNextStateNumber()}',
          leftButtonOnTap: () => Navigator.pop(context),
          rightButtonOnTap: () {
            GameStateManager.addLastMoveCardAction(
                [Scenario.currentScenario.killedInDayPlayer!],
                LastMoveCardPage.selectedLastMoveCard!);
            LastMoveCardPage.selectedLastMoveCard!.lastMoveCardAction([
              Player.getPlayerByName(
                  Scenario.currentScenario.killedInDayPlayer!.name)
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
                      borderRadius:
                          BorderRadius.circular(5), // Circular border radius
                      border: Border.all(
                        color:
                            determineRoleCardBorderColor(), // Optional: Border color
                        width: 2, // Optional: Border width
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                            LastMoveCardPage.selectedLastMoveCard!.imagePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: CallRole(
                      text:
                          "${Scenario.currentScenario.killedInDayPlayer!.name} قبل از بیرون رفتن از بازی باید یک دروغ بگه.",
                      onPressed: () {},
                      buttonText: ""),
                ),
              ),
            ],
          ),
        ));
  }
}
