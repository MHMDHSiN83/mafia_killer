import 'package:flutter/material.dart';
import 'package:mafia_killer/components/confirmation_box.dart';
import 'package:mafia_killer/components/night_player_tile.dart';
import 'package:mafia_killer/components/player_status_tile.dart';
import 'package:mafia_killer/components/remove_player_tile.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/models/player_status.dart';
import 'package:mafia_killer/themes/app_color.dart';

class PlayerStatusDialogbox extends StatefulWidget {
  const PlayerStatusDialogbox({super.key, required this.reloadPage});

  final Function reloadPage;
  @override
  State<PlayerStatusDialogbox> createState() => _PlayerStatusDialogboxState();
}

class _PlayerStatusDialogboxState extends State<PlayerStatusDialogbox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actions: [
          Center(
            child: TextButton(
                onPressed: () {
                  widget.reloadPage();
                  Navigator.pop(context);
                },
                child: Text(
                  "متوجه شدم",
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
          width: 350,
          height: 500,
          child: GridView.builder(
              itemCount: Player.inGamePlayers.length,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of tiles per row
                childAspectRatio: 1, // Width/height ratio of tiles
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return PlayerStatusTile(
                  player: Player.inGamePlayers[index],
                );
              }),
        ));
  }
}
