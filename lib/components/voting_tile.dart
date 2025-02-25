import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/themes/app_color.dart';

class VotingTile extends StatefulWidget {
  VotingTile({
    super.key,
    required this.player,
    required this.addPlayer,
    required this.removePlayer,
    required this.stamp,
    this.isClicked,
  });

  Player player;
  VoidCallback addPlayer;
  VoidCallback removePlayer;
  String stamp;
  bool? isClicked;

  @override
  State<VotingTile> createState() => _VotingTileState();
}

class _VotingTileState extends State<VotingTile> {
  @override
  Widget build(BuildContext context) {
    if (widget.isClicked == null) {
      widget.isClicked = false;
    }
    return GestureDetector(
      onTap: () {
        if (widget.isClicked!) {
          widget.removePlayer();
        } else {
          widget.addPlayer();
        }
        widget.isClicked = !widget.isClicked!;
      },
      child: Stack(
        children: [
          Opacity(
            opacity: widget.isClicked! ? 0.3 : 1,
            child: Container(
              width: 150,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('lib/images/backgrounds/signpost.png'),
                fit: BoxFit.cover,
              )),
              child: Column(
                children: [
                  const SizedBox(
                    height: 65,
                  ),
                  Text(
                    widget.player.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brownColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.isClicked!,
            child: Positioned(
              top: 63,
              right: 15,
              child: Transform.rotate(
                angle: 75,
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      color: AppColors.redColor,
                      width: 3.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.stamp,
                      style: TextStyle(
                        color: AppColors.redColor,
                        fontSize: (widget.stamp.length >= 11) ? 13 : 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
