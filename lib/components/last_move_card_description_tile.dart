import 'package:flutter/material.dart';
import 'package:mafia_killer/models/last_move_card.dart';

// ignore: must_be_immutable
class LastMoveCardsDescriptionTile extends StatelessWidget {
  LastMoveCardsDescriptionTile({super.key, required this.lastMoveCard});
  LastMoveCard lastMoveCard;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 700,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black,
          width: 2.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            width: 280,
            child: Image(
              image: AssetImage(
                lastMoveCard.selectionImagePath,
              ),
            ),
          ),
          Text(
            lastMoveCard.description,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
