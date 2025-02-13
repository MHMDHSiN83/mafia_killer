import 'package:flutter/material.dart';
import 'package:mafia_killer/components/last_move_card_description_tile.dart';
import 'package:mafia_killer/databases/scenario.dart';
import 'package:mafia_killer/models/language.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/themes/app_color.dart';

class LastMoveCardSelectionTile extends StatefulWidget {
  LastMoveCardSelectionTile(
      {super.key, required this.lastMoveCard, required this.counter});
  LastMoveCard lastMoveCard;
  int counter;
  @override
  State<LastMoveCardSelectionTile> createState() =>
      _LastMoveCardSelectionTileState();
}

class _LastMoveCardSelectionTileState extends State<LastMoveCardSelectionTile> {
  // Color determineColor() {
  //   Color color;
  //   switch (widget.role.roleSide) {
  //     case RoleSide.mafia:
  //       color = AppColors.redColor;
  //       break;
  //     case RoleSide.citizen:
  //       color = AppColors.darkgreenColor;

  //       break;
  //     case RoleSide.independant:
  //       color = const Color(0xFFFEE604);

  //       break;
  //   }
  //   return color;
  // }

  void increaseNumber() {
    // TODO
    // if (Player.inGamePlayers.length <=
    //     Scenario.currentScenario.inGameRoles.length) {
    //   return;
    // }
    setState(() {
      widget.counter++;
    });
    Scenario.addLastMoveCard(widget.lastMoveCard);
  }

  void decreaseNumber() {
    if (widget.counter == 0) {
      return;
    }
    setState(() {
      widget.counter--;
    });
    Scenario.removeLastMoveCard(widget.lastMoveCard);
  }

  @override
  Widget build(BuildContext context) {
    // Color color = determineColor();
    Color color = Colors.white;
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: LastMoveCardsDescriptionTile(lastMoveCard: widget.lastMoveCard),
              );
            });
      },
      child: Container(
        width: 200,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: color,
            width: 2.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: Image(
                image: AssetImage(
                  widget.lastMoveCard.imagePath,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Material(
                    color: AppColors.darkgreenColor, // Button color
                    child: InkWell(
                      splashColor: AppColors.hoverGreenColor, // Splash color
                      onTap: increaseNumber,
                      child: const SizedBox(
                        width: 28,
                        height: 28,
                        child: Icon(
                          Icons.add,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  Language.toPersian(widget.counter.toString()),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                ClipOval(
                  child: Material(
                    color: AppColors.redColor, // Button color
                    child: InkWell(
                      splashColor: AppColors.hoverRedColor, // Splash color
                      onTap: decreaseNumber,
                      child: const SizedBox(
                        width: 28,
                        height: 28,
                        child: Icon(
                          Icons.remove,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
