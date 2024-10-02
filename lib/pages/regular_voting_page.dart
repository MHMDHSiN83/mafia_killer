import 'package:flutter/material.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';

class RegularVotingPage extends StatelessWidget {
  const RegularVotingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double horizantalMargin = 40.0;

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
        pageTitle: "بازیکنان داخل دفاع",
        leftButtonText: "صحبت روز",
        rightButtonText: "صحبت دفاعیه",
        //leftButtonIcon: Icons.keyboard_arrow_left,
        //rightButtonIcon: Icons.keyboard_arrow_right,
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () =>
            Navigator.pushNamed(context, '/defense_voting_page'),
        child: ListView.builder(
          itemCount: (players.length / 2)
              .ceil(), // Divide by 2 because each row has two items
          itemBuilder: (context, index) {
            int firstItemIndex = index * 2;
            int secondItemIndex = firstItemIndex + 1;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizantalMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VotingTile(
                    player: players[firstItemIndex],
                    isRegularVoting: true,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (secondItemIndex <
                      players.length) // Check if second item exists
                    VotingTile(
                      player: players[secondItemIndex],
                      isRegularVoting: true,
                    )
                  else
                    VotingTile(
                      player: players[secondItemIndex - 1],
                      isRegularVoting: true,
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
