import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mafia_killer/components/end_game_player_tile.dart';
import 'package:mafia_killer/components/page_frame.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/role_side.dart';
import 'package:mafia_killer/models/scenarios/godfather/roles/nostradamus.dart';

class EndGamePage extends StatelessWidget {
  EndGamePage({super.key});

  final List<Player> mafiaPlayers = Player.inGamePlayers
      .where((x) =>
          x.role?.roleSide == RoleSide.mafia ||
          ((x.role! is Nostradamus) &&
              (x.role! as Nostradamus).inGameRoleSide == RoleSide.mafia))
      .toList();
  final List<Player> citizenPlayers = Player.inGamePlayers
      .where((x) =>
          x.role?.roleSide == RoleSide.citizen ||
          ((x.role! is Nostradamus) &&
              (x.role! as Nostradamus).inGameRoleSide == RoleSide.citizen))
      .toList();
  final Player independentPlayer = Player.inGamePlayers
      .where((x) => x.role?.roleSide == RoleSide.independant)
      .first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageFrame(
        isInGame: false,
        label: ModalRoute.of(context)!.settings.name!,
        pageTitle: 'پایان بازی',
        leftButtonText: "خروج",
        rightButtonText: "بازی مجدد",
        leftButtonOnTap: () {
          Navigator.pop(context);
        },
        rightButtonOnTap: () {
          Navigator.pushNamed(context, '/intro_page');
        },
        child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                    image: AssetImage('lib/images/endgame/Mafia-Won.png'),
                  ),
                ),
                Positioned(
                  top: 235, // Adjust as needed
                  left: 0,
                  right: 0, // Ensures it stretches across the screen
                  child: SizedBox(
                    width: double.infinity, // Makes sure it takes full width
                    height: 420,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      itemCount: mafiaPlayers.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: EndGamePlayerTile(
                            player: mafiaPlayers[index],
                            roleSide: RoleSide.mafia,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
