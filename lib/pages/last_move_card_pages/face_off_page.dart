import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/player_status.dart';

//  ----- FIRST PAGE OF FACE-OFF LAST MOVE CARD ------
class FaceOffPage extends StatefulWidget {
  const FaceOffPage({super.key});
  static List<Player> selectedPlayers = [];
  @override
  State<FaceOffPage> createState() => _FaceOffPageState();
}

class _FaceOffPageState extends State<FaceOffPage> {
  void addPlayer(Player player) {
    if (FaceOffPage.selectedPlayers.isEmpty) {
      FaceOffPage.selectedPlayers.add(player);
    }
  }

  void removePlayer(Player player) {
    if (FaceOffPage.selectedPlayers.contains(player)) {
      FaceOffPage.selectedPlayers.remove(player);
    }
  }

  bool isDisable(Player player) {
    bool result = true;
    setState(() {
      if (FaceOffPage.selectedPlayers.isEmpty) {
        result = false;
      }
      if (FaceOffPage.selectedPlayers.contains(player)) {
        result = false;
      }
    });
    return result;
  }

  List<Player> alivePlayers = Player.getAlivePlayers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        pageTitle: "تغییر چهره",
        leftButtonText: "کارت حرکت آخر",
        rightButtonText:
            'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          if (FaceOffPage.selectedPlayers.length == 1) {
            Navigator.pushNamed(context, '/faced_off_role_page');
          }
        },
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of tiles per row
                    childAspectRatio: 1, // Width/height ratio of tiles
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                  ),
                  itemCount: alivePlayers.length,
                  itemBuilder: (context, index) {
                    return VotingTile(
                      stamp: "تغییر چهره",
                      player: alivePlayers[index],
                      isRegularVoting: false,
                      addPlayer: () {
                        addPlayer(alivePlayers[index]);
                      },
                      removePlayer: () {
                        removePlayer(alivePlayers[index]);
                      },
                      disable: () => isDisable(alivePlayers[index]),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CallRole(
                  text:
                      "${Scenario.currentScenario.killedInDayPlayer!.name} یک نفرو انتخاب کنه و نقششو باهاش عوض کنه.",
                  buttonText: "",
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
