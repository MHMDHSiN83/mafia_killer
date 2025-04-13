import 'package:flutter/material.dart';
import 'package:mafia_killer/models/last_move_card.dart';
import 'package:mafia_killer/themes/app_color.dart';

class LastMoveCardGuideTile extends StatelessWidget {
  const LastMoveCardGuideTile({super.key, required this.lastMoveCard});

  final LastMoveCard lastMoveCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.darkgreenColor, width: 2)),
      elevation: 4,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Product Image

              // Description and Details
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lastMoveCard.title,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkgreenColor),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      lastMoveCard.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[300]),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
