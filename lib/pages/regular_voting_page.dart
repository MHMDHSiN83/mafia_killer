import 'package:flutter/material.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/talking_page_screen_arguments.dart';

class RegularVotingPage extends StatefulWidget {
  const RegularVotingPage({super.key});

  @override
  State<RegularVotingPage> createState() => _RegularVotingPageState();
}

class _RegularVotingPageState extends State<RegularVotingPage> {
  List<Player> defendingPlayers = [];

  void addPlayer(Player player) {
    setState(() {
      defendingPlayers.add(player);
    });
  }

  void removePlayer(Player player) {
    setState(() {
      defendingPlayers.remove(player);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        label: ModalRoute.of(context)!.settings.name!,
        pageTitle: "بازیکنان داخل دفاع",
        reloadContentOfPage: () {
          setState(() {});
        },
        leftButtonText: "صحبت روز",
        rightButtonText: "صحبت دفاعیه",
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          Scenario.currentScenario.storeDefendingPlayers(defendingPlayers);
          if (Scenario.currentScenario.defendingPlayers.isNotEmpty) {
            Navigator.pushNamed(
              context,
              '/talking_page',
              arguments: TalkingPageScreenArguments(
                nextPagePath: '/defense_voting_page',
                seconds: GameSettings.currentGameSettings.mainSpeakTime,
                leftButtonText: 'رای گیری',
                rightButtonText: 'رای گیری دفاعیه',
                isDefense: true,
              ),
            );
          } else {
            Scenario.currentScenario.goToNextStage();

            Navigator.pushNamed(context, '/night_page');
          }
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
            itemCount: Player.inGamePlayers
                .where((player) => player.playerStatus == PlayerStatus.active)
                .toList()
                .length,
            itemBuilder: (context, index) {
              return VotingTile(
                player: Player.inGamePlayers
                    .where(
                        (player) => player.playerStatus == PlayerStatus.active)
                    .toList()[index],
                addPlayer: () {
                  addPlayer(Player.inGamePlayers
                      .where((player) =>
                          player.playerStatus == PlayerStatus.active)
                      .toList()[index]);
                },
                removePlayer: () {
                  removePlayer(Player.inGamePlayers
                      .where((player) =>
                          player.playerStatus == PlayerStatus.active)
                      .toList()[index]);
                },
                isClicked: defendingPlayers
                    .contains(Player.inGamePlayers
                      .where((player) =>
                          player.playerStatus == PlayerStatus.active)
                      .toList()[index]),
                stamp: 'دفاعیه',
              );
            },
          ),
        ),
      ),
    );
  }
}
