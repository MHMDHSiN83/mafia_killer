import 'package:flutter/material.dart';
import 'package:mafia_killer/components/last_move_card_selection_tile.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/role_selection_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/ad_manager.dart';
import 'package:mafia_killer/utils/audio_manager.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';

class RoleSelectionPage extends StatelessWidget {
  RoleSelectionPage({super.key});

  List<Role> mafiaRoles = [];
  List<Role> citizenRoles = [];
  List<Role> independantRoles = [];

  void getRoles() async {
    mafiaRoles = Scenario.currentScenario.getRolesBySide(RoleSide.mafia);
    citizenRoles = Scenario.currentScenario.getRolesBySide(RoleSide.citizen);
    independantRoles =
        Scenario.currentScenario.getRolesBySide(RoleSide.independant);
  }

  
  @override
  Widget build(BuildContext context) {
    AdManager.prepareAd();
    getRoles();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageFrame(
        label: '/role_selection_page',
        isInGame: false,
        pageTitle: " نقش‌های بازی",
        leftButtonText: "تنظیمات بازی",
        rightButtonText: "توزیع نقش‌ها",
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          int roleLength = Scenario.currentScenario.inGameRoles.length;
          if (Player.inGamePlayers.length != roleLength) {
            customSnackBar(
                context, 'تعداد نقش‌ها با تعداد بازیکن‌ها برابر نیست', true);
            return;
          } else {
            int mafiaCount =
                Scenario.currentScenario.getNumberOfRoleBySide(RoleSide.mafia);
            int citizenCount = Scenario.currentScenario
                .getNumberOfRoleBySide(RoleSide.citizen);
            int independantCount = Scenario.currentScenario
                .getNumberOfRoleBySide(RoleSide.independant);
            if (mafiaCount == 0) {
              customSnackBar(context, 'تعداد مافیا ها نمی‌تونه صفر باشه', true);
              return;
            } else if (citizenCount + independantCount <= mafiaCount) {
              customSnackBar(
                  context,
                  'تعداد مافیاها باید از مجموع شهروندها و نوستراداموس کمتر باشه',
                  true);
              return;
            } else if (roleLength < 5) {
              customSnackBar(
                  context, 'تعداد بازیکن‌ها نمی‌تونه از پنج کمتر باشه', true);
              return;
            } else if (!(Scenario.currentScenario as GodfatherScenario)
                    .doesNostradamusParticipate() &&
                (Scenario.currentScenario as GodfatherScenario)
                    .doesBeautifulMindParticipate()) {
              customSnackBar(
                  context,
                  "وقتی نوستراداموس توی بازی نیست، کارت ذهن زیبا قابل استفاده نیست",
                  true);
              return;
            }
          }
          (Scenario.currentScenario as GodfatherScenario)
              .shuffleLastMoveCards();
          // List<Role> roles =
          //     Role.copyList(Scenario.currentScenario.inGameRoles);

          // roles.shuffle();
          // for (int i = 0; i < Player.inGamePlayers.length; i++) {
          //   Player.inGamePlayers[i].role = roles[i];
          // }
          // (Scenario.currentScenario as GodfatherScenario)
          //     .setNostradamusInquiryNumber();
          AudioManager.playNextPageEffect();
          Navigator.pushNamed(context, '/role_distribution_page');
          // Navigator.pushNamed(
          //   context,
          //   '/talking_page',
          //   arguments: TalkingPageScreenArguments(
          //       nextPagePath: '/intro_night_page',
          //       seconds: GameSettings.currentGameSettings.introTime,
          //       rightButtonText: "شب معارفه",
          //       leftButtonText: "تقسیم نقش",
          //       isDefense: false),
          // );
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            const Text(
              "مافیا",
              style: TextStyle(
                fontSize: 38,
                shadows: [
                  Shadow(color: AppColors.redColor, offset: Offset(0, -12))
                ],
                color: Colors.transparent,
                //decoration: TextDecoration.underline,
                decorationColor: AppColors.redColor,
                decorationThickness: 2,
              ),
            ),
            SizedBox(
              height: 265,
              child: ListView.builder(
                // padding: const EdgeInsets.all(10),
                itemCount: mafiaRoles.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: RoleSelectionTile(
                      role: mafiaRoles[index],
                      counter: Scenario.currentScenario
                          .numberOfRoles(mafiaRoles[index]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "شهروند",
              style: TextStyle(
                fontSize: 38,
                shadows: [
                  Shadow(color: AppColors.blueColor, offset: Offset(0, -12))
                ],
                color: Colors.transparent,
                //decoration: TextDecoration.underline,
                decorationColor: AppColors.blueColor,
                decorationThickness: 2,
              ),
            ),
            SizedBox(
              height: 265,
              child: ListView.builder(
                // padding: const EdgeInsets.all(10),
                itemCount: citizenRoles.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: RoleSelectionTile(
                      role: citizenRoles[index],
                      counter: Scenario.currentScenario
                          .numberOfRoles(citizenRoles[index]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "مستقل",
              style: TextStyle(
                fontSize: 38,
                shadows: [
                  Shadow(color: AppColors.yellowColor, offset: Offset(0, -12))
                ],
                color: Colors.transparent,
                //decoration: TextDecoration.underline,
                decorationColor: AppColors.yellowColor,
                decorationThickness: 2,
              ),
            ),
            SizedBox(
              height: 265,
              child: ListView.builder(
                // padding: const EdgeInsets.all(10),
                itemCount: independantRoles.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: RoleSelectionTile(
                      role: independantRoles[index],
                      counter: Scenario.currentScenario
                          .numberOfRoles(independantRoles[index]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "کارت حرکت آخر",
              style: TextStyle(
                fontSize: 38,
                shadows: [
                  Shadow(
                    color: AppColors.darkgreenColor,
                    offset: Offset(0, -12),
                  )
                ],
                color: Colors.transparent,
                //decoration: TextDecoration.underline,
                decorationColor: AppColors.darkgreenColor,
                decorationThickness: 2,
              ),
            ),
            SizedBox(
              height: 160,
              child: ListView.builder(
                itemCount: Scenario.currentScenario.lastMoveCards.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: LastMoveCardSelectionTile(
                      lastMoveCard:
                          Scenario.currentScenario.lastMoveCards[index],
                      counter: Scenario.currentScenario.numberOfLastMoveCards(
                          Scenario.currentScenario.lastMoveCards[index]),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
