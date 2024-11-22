import 'package:flutter/material.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';

class DefenseVotingPage extends StatelessWidget {
  const DefenseVotingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        pageTitle: "کشته روز",
        leftButtonText: "صحبت دفاعیه",
        rightButtonText:
            'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          Scenario.currentScenario.goToNextStage();
          Navigator.pushNamed(
            context,
            '/night_page',
          );
        },
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of tiles per row
              childAspectRatio: 1.0, // Width/height ratio of tiles
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
            itemCount: GodfatherScenario.defendingPlayers.length,
            itemBuilder: (context, index) {
              return VotingTile(
                player: GodfatherScenario.defendingPlayers[index],
                isRegularVoting: false,
                addPlayer: () {
                  // addPlayer(Player.inGamePlayers[index]);
                },
                removePlayer: () {
                  // removePlayer(Player.inGamePlayers[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
