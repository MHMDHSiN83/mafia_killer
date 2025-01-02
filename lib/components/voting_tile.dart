import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/themes/app_color.dart';

class VotingTile extends StatefulWidget {
  VotingTile({
    super.key,
    required this.player,
    required this.isRegularVoting,
    required this.addPlayer,
    required this.removePlayer,
    required this.disable,
    this.stamp,
  });

  Player player;
  bool isRegularVoting;
  VoidCallback addPlayer;
  VoidCallback removePlayer;
  Function disable;
  String? stamp;

  @override
  State<VotingTile> createState() => _VotingTileState();
}

class _VotingTileState extends State<VotingTile> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.disable()) {
          setState(() {
            if (isClicked) {
              widget.removePlayer();
            } else {
              widget.addPlayer();
            }
            isClicked = !isClicked;
          });
        }
      },
      child: Stack(
        children: [
          Opacity(
            opacity: isClicked ? 0.3 : 1,
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
            visible: isClicked,
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
                      (widget.stamp != null)
                          ? widget.stamp!
                          : (widget.isRegularVoting)
                              ? "دفاعیه"
                              : "کشته",
                      style: TextStyle(
                        color: AppColors.redColor,
                        fontSize:
                            (widget.stamp != null && widget.stamp!.length >= 11)
                                ? 13
                                : 20,
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
