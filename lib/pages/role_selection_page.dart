import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/role_selection_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/themes/app_color.dart';

class RoleSelectionPage extends StatelessWidget {
  RoleSelectionPage({super.key});

  List<Role> mafiaRoles = [];
  List<Role> citizenRoles = [];
  List<Role> independantRoles = [];
  final int numberOfPlayers = Player.players.length;
  void getRoles() async {
    mafiaRoles = Scenario.currentScenario.getRolesBySide(RoleSide.mafia);
    citizenRoles = Scenario.currentScenario.getRolesBySide(RoleSide.citizen);
    independantRoles =
        Scenario.currentScenario.getRolesBySide(RoleSide.independant);
  }

  @override
  Widget build(BuildContext context) {
    getRoles();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageFrame(
        pageTitle: " نفش‌های بازی",
        leftButtonText: "قبلی",
        rightButtonText: "بعدی",
        leftButtonIcon: Icons.keyboard_arrow_left,
        rightButtonIcon: Icons.keyboard_arrow_right,
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () => Navigator.pushNamed(context, '/talking_page'),
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
                decoration: TextDecoration.underline,
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
                  Shadow(
                      color: AppColors.darkgreenColor, offset: Offset(0, -12))
                ],
                color: Colors.transparent,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.darkgreenColor,
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
                  Shadow(color: Color(0xFFFEE604), offset: Offset(0, -12))
                ],
                color: Colors.transparent,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFFEE604),
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
