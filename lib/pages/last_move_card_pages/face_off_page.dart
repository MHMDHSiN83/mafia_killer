import 'package:flutter/material.dart';
import 'package:mafia_killer/components/call_role.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/components/voting_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/utils/custom_snackbar.dart';
import 'package:mafia_killer/utils/audio_manager.dart';

//  ----- FIRST PAGE OF FACE-OFF LAST MOVE CARD ------
class FaceOffPage extends StatefulWidget {
  const FaceOffPage({super.key});
  static List<Player> selectedPlayers = [];
  @override
  State<FaceOffPage> createState() => _FaceOffPageState();
}

class _FaceOffPageState extends State<FaceOffPage> {
  void addPlayer(Player player) {
    setState(() {
      FaceOffPage.selectedPlayers.add(player);
      if (FaceOffPage.selectedPlayers.length == 2) {
        FaceOffPage.selectedPlayers.removeAt(0);
      }
    });
  }

  void removePlayer(Player player) {
    setState(() {
      if (FaceOffPage.selectedPlayers.contains(player)) {
        FaceOffPage.selectedPlayers.remove(player);
      }
    });
  }

  Player killedInDayPlayer = Scenario.currentScenario.killedInDayPlayer!;
  List<Player> alivePlayers =
      Player.getAlivePlayersExcept(Scenario.currentScenario.killedInDayPlayer!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFrame(
        label: '/face_off_page',
        pageTitle: "تغییر چهره",
        leftButtonText: "کارت حرکت آخر",
        rightButtonText:
            'شب ${Scenario.currentScenario.dayAndNightNumber(number: Scenario.currentScenario.nightNumber)}',
        leftButtonOnTap: () => Navigator.pop(context),
        rightButtonOnTap: () {
          if (FaceOffPage.selectedPlayers.length == 1) {
            AudioManager.playNextPageEffect();
            Navigator.pushNamed(context, '/faced_off_role_page');
          } else {
            customSnackBar(context, "باید حتما یک بازیکن را انتخاب کنید.", true);
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
                      addPlayer: () {
                        addPlayer(alivePlayers[index]);
                      },
                      removePlayer: () {
                        removePlayer(alivePlayers[index]);
                      },
                      isClicked: FaceOffPage.selectedPlayers
                          .contains(alivePlayers[index]),
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
                      "${killedInDayPlayer.name} یک نفرو انتخاب کنه و نقششو باهاش عوض کنه.",
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
