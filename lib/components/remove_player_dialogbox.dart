import 'package:flutter/material.dart';
import 'package:mafia_killer/components/confirmation_box.dart';
import 'package:mafia_killer/components/night_player_tile.dart';
import 'package:mafia_killer/components/remove_player_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/themes/app_color.dart';

class RemovePlayerDialogbox extends StatefulWidget {
  RemovePlayerDialogbox({super.key, required this.reloadPage});

  Function reloadPage;
  @override
  State<RemovePlayerDialogbox> createState() => _RemovePlayerDialogboxState();
}

class _RemovePlayerDialogboxState extends State<RemovePlayerDialogbox> {
  List<Player> alivePlayers = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    alivePlayers = Player.getAliveInGamePlayers();
    return AlertDialog(
        actions: [
          Center(
            child: TextButton(
                onPressed: () {
                  widget.reloadPage();
                  Navigator.pop(context);
                },
                child: Text(
                  "انجام شد",
                  style: TextStyle(color: AppColors.redColor, fontSize: 17),
                )),
          )
        ],
        content: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: null,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF111111),
                Color.fromRGBO(40, 7, 7, 1),
                Color.fromARGB(255, 52, 0, 0),
              ],
            ),
          ),
          // color: Colors.blue,
          width: 300,
          height: 450,
          child: GridView.builder(
            itemCount: alivePlayers.length,
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of tiles per row
              childAspectRatio: 1, // Width/height ratio of tiles
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return RemovePlayerTile(
                  player: alivePlayers[index],
                  confirmAction: () {
                    showDialog(
                        context: context,
                        builder: (context) => ConfirmationBox(onSave: () {
                              Navigator.pop(context);
                              setState(() {
                                alivePlayers[index].playerStatus =
                                    PlayerStatus.removed;
                              });
                            }, onCancel: () {
                              Navigator.pop(context);
                            }));
                  });
            },
          ),
        ));
  }
}
