import 'package:flutter/material.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/scenarios/godfather/godfather_scenario.dart';
import 'package:mafia_killer/models/talking_page_screen_arguments.dart';

class RegularVotingPage extends StatefulWidget {
  const RegularVotingPage({super.key});

  @override
  State<RegularVotingPage> createState() => _RegularVotingPageState();
}

class _RegularVotingPageState extends State<RegularVotingPage> {
  List<Player> defendingPlayers = [];

  void addPlayer(Player player) {
    defendingPlayers.add(player);
  }

  void removePlayer(Player player) {
    defendingPlayers.remove(player);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        pageTitle: "بازیکنان داخل دفاع",
        reloadContentOfPage: () {
          setState(() {});
        },
        leftButtonText: "صحبت روز",
        rightButtonText: "صحبت دفاعیه",
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          GodfatherScenario.storeDefendingPlayers(defendingPlayers);
          if (GodfatherScenario.defendingPlayers.isNotEmpty) {
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
                isRegularVoting: true,
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
                disable: () => false,
              );
            },
          ),
        ),
      ),
    );
  }
}
