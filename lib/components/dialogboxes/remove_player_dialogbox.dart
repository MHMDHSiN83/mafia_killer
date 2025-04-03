import 'package:flutter/material.dart';
import 'package:mafia_killer/components/dialogboxes/confirmation_dialogbox.dart';
import 'package:mafia_killer/components/remove_player_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/themes/app_color.dart';
import 'package:mafia_killer/utils/audio_manager.dart';

class RemovePlayerDialogbox extends StatefulWidget {
  const RemovePlayerDialogbox({super.key, required this.reloadPage});

  final Function reloadPage;
  @override
  State<RemovePlayerDialogbox> createState() => _RemovePlayerDialogboxState();
}

class _RemovePlayerDialogboxState extends State<RemovePlayerDialogbox> {
  List<Player> allPlayers = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    allPlayers = Player.inGamePlayers;
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
            itemCount: allPlayers.length,
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of tiles per row
              childAspectRatio: 1, // Width/height ratio of tiles
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return RemovePlayerTile(
                  player: allPlayers[index],
                  confirmAction: () {
                    showDialog(
                        context: context,
                        builder: (context) => ConfirmationDialogbox(onSave: () {
                              AudioManager.playDeleteEffect();
                              Navigator.pop(context);
                              setState(() {
                                allPlayers[index].playerStatus =
                                    PlayerStatus.removed;
                              });
                            }, onCancel: () {
                              AudioManager.playClickEffect();
                              Navigator.pop(context);
                            }));
                  });
            },
          ),
        ));
  }
}
