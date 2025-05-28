import 'package:flutter/material.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/themes/app_color.dart';

// ignore: must_be_immutable
class LastMoveCardsDescriptionTile extends StatelessWidget {
  LastMoveCardsDescriptionTile({super.key, required this.lastMoveCard});
  LastMoveCard lastMoveCard;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 350,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.darkgreenColor,
          width: 2.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 0,
            ),
            width: 280,
            child: Image(
              image: AssetImage(
                lastMoveCard.selectionImagePath,
              ),
            ),
          ),
          Container(
            height: 120,
            margin: EdgeInsets.fromLTRB(20, 0, 20.0, 0),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView(children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        lastMoveCard.description,
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkgreenColor,
              elevation: 12.0,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(
                'متوجه شدم',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
