import 'package:flutter/material.dart';
import 'package:mafia_killer/databases/player.dart';
import 'package:mafia_killer/themes/app_color.dart';

class VotingTile extends StatefulWidget {
  VotingTile({super.key, required this.player, required this.isRegularVoting});

  Player player;
  bool isRegularVoting;

  @override
  State<VotingTile> createState() => _VotingTileState();
}

class _VotingTileState extends State<VotingTile> {
  double opacity = 1.0;
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (opacity == 1) {
            opacity = 0.3;
          } else {
            opacity = 1.0;
          }
          isClicked = !isClicked;
        });
      },
      child: Stack(children: [
        Opacity(
          opacity: opacity,
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('lib/images/backgrounds/signpost.png'),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Text(
                  widget.player.name,
                  style: const TextStyle(
                    fontSize: 25,
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
            top: 75,
            right: 25,
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
                    (widget.isRegularVoting) ? "دفاعیه" : "کشته",
                    style: const TextStyle(
                      color: AppColors.redColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
