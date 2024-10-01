import 'package:flutter/material.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/player_role_card.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role.dart';
import 'package:mafia_killer/themes/app_color.dart';

class RoleDistributionPage extends StatefulWidget {
  const RoleDistributionPage({super.key});

  @override
  State<RoleDistributionPage> createState() => _RoleDistributionPageState();
}

class _RoleDistributionPageState extends State<RoleDistributionPage> {
  void playerCardOnClick() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const double horizantalMargin = 40.0;
    // for (var role in Scenario.currentScenario.roles) {
    //   print(role.name);
    // }
    Player player = Player("امین");
    player.role = Scenario.currentScenario.getRoleByName("پدرخوانده")!;
    Player player2 = Player("رضا");
    player2.role = Scenario.currentScenario.getRoleByName("نوستراداموس")!;
    Player player3 = Player("حسین");
    player3.role = Scenario.currentScenario.getRoleByName("لئون حرفه‌ای")!;
    List<Player> players = [
      player,
      player,
      player,
      player,
      player,
      player,
      player,
      player2,
      player3,
      player2,
      player3,
    ];

    return Scaffold(
      body: PageFrame(
        pageTitle: "تقسیم نقش ها",
        leftButtonText: "قبلی",
        rightButtonText: "بعدی",
        leftButtonIcon: Icons.keyboard_arrow_left,
        rightButtonIcon: Icons.keyboard_arrow_right,
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () => Navigator.pushNamed(context, '/loading_page'),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: horizantalMargin),
                padding: const EdgeInsets.symmetric(vertical: 0),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: AppColors.redColor,
                  width: 3,
                )),
                child: const Center(
                  child: Text(
                    "روی اسم خودت بزن",
                    style: TextStyle(fontSize: 28, color: AppColors.redColor),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 14,
              child: ListView.builder(
                itemCount: (players.length / 2)
                    .ceil(), // Divide by 2 because each row has two items
                itemBuilder: (context, index) {
                  int firstItemIndex = index * 2;
                  int secondItemIndex = firstItemIndex + 1;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizantalMargin, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PlayerRoleCard(
                          player: players[firstItemIndex],
                          onTap: () {},
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (secondItemIndex <
                            players.length) // Check if second item exists
                          PlayerRoleCard(
                            player: players[secondItemIndex],
                            onTap: () {},
                          )
                        else
                          PlayerRoleCard(
                            player: players[secondItemIndex - 1],
                            isVisible: false,
                            onTap:
                                () {}, // it's a hidden object so there will be no onTap
                          )
                      ],
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
