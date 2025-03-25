import 'package:flutter/material.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/game_settings.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/models/talking_page_screen_arguments.dart';
import 'package:mafia_killer/utils/audio_manager.dart';

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

  List<Player> alivePlayers = Player.inGamePlayers
      .where((player) =>
          player.playerStatus != PlayerStatus.dead &&
          player.playerStatus != PlayerStatus.removed)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        label: '/regular_voting_page',
        pageTitle: "رای‌ گیری",
        reloadContentOfPage: () {
          setState(() {});
        },
        leftButtonText: "صحبت روز",
        rightButtonText: "صحبت دفاعیه",
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          Scenario.currentScenario.storeDefendingPlayers(defendingPlayers);
          AudioManager.playNextPageEffect();
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
            itemCount: alivePlayers.length,
            itemBuilder: (context, index) {
              return VotingTile(
                player: alivePlayers[index],
                addPlayer: () {
                  addPlayer(alivePlayers[index]);
                },
                removePlayer: () {
                  removePlayer(alivePlayers[index]);
                },
                isClicked: defendingPlayers.contains(alivePlayers[index]),
                stamp: 'دفاعیه',
              );
            },
          ),
        ),
      ),
    );
  }
}
